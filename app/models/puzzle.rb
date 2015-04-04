class Puzzle < ActiveRecord::Base
  serialize :board
  serialize :original
  serialize :solution

  def board=(board)
    super(board.map(&:to_i))
  end

  def setup_puzzle
    self.original = board
    self.solution = solve_puzzle
    self.board = self.original
    self
  end

  def display
    board.each_slice(9) do |row|
      puts row.join
    end
    nil
  end

  def find_pos(index)
    row = index / 9
    column = index % 9
    [row, column]
  end

  def find_index(pos)
    pos[0] * 9 + pos[1]
  end

  def solve_puzzle
    setup_solve_variables
    guess_process
  end

  def setup_solve_variables
    @guessed = false
    @after_guess = []
    @guess =[]
    @incorrect=[]
  end

  def guess_process
    loop do
      if solvable?
        complete_puzzle
        if check_incomplete == 0
          break
        elsif solvable?
          take_a_guess(pick_empty)
          guess_process
          break if check_incomplete == 0
        else
          backtrack
        end
      else
        break
      end
    end
    return board
  end

  def solvable?
    open_places = available_places
    open_places.each do |place|
      if check_place(*place).empty?
        return false
      end
    end
    9.times do |i|
      row = get_row(i)
      column = get_column(i)
      square = get_square((i/3)*3, (i % 3)*3)
      [row, column, square].each do |group|
        group.reject!{ |num| num == 0}
        return false if group.length != group.uniq.length
      end
    end
    true
  end

  def available_places
    open_places=[]
    (0..8).each do |row|
      (0..8).each do |column|
        if board[find_index([row, column])] == 0
          open_places << [row, column]
        end
      end
    end
    open_places
  end

  def check_place (row, column)
    index = find_index([row, column])
    return board[index] if board[index] != 0
    check_row(row) & check_column(column) & check_square(row, column)
  end

  def get_row(row)
    board[find_index([row, 0])..find_index([row, 8])]
  end

  def check_row(row)
    row = get_row(row)
    check(row)
  end

  def get_column(column)
    column_nums = []
    9.times do |i|
      column_nums << board[find_index([i, column])]
    end
    column_nums
  end

  def check_column(column)
   column = get_column(column)
   check(column)
  end

  def get_square(row, column)
    row = (row / 3) * 3
    column = (column / 3) * 3
    square_nums = []
    (0..2).each do |row_delta|
      (0..2).each do |column_delta|
        new_row = row + row_delta
        new_column = column + column_delta
        square_nums << board[find_index([new_row, new_column])]
      end
    end
    square_nums
  end

  def check_square(row, column)
    square = get_square(row, column)
    check(square)
  end

  def check(nums)
    possible=[]
    (1..9).each {|num| possible << num if !nums.include?(num) }
    possible
  end

  def blank_board
    board=Array.new(81, 0)
  end

  def complete_puzzle
    incomplete = check_incomplete
    while incomplete > 0
      start = incomplete
      solve_squares
      incomplete = check_incomplete
      if incomplete == start
        compare_squares
        compare_rows
        compare_columns
        incomplete = check_incomplete
        if incomplete == start
          break
        end
      end
    end
  end

  def check_incomplete
    board.count(0)
  end

  def solve_squares
    (0..8).each do |row|
      (0..8).each do |column|
        options = check_place(row, column)
        if options.class == Array && options.length == 1
          board[find_index([row, column])] = options.first
          @after_guess << [row, column] if @guessed
        end
      end
    end
    self
  end

  def find_set_options(places)
    options=[]
    places.each do |place|
      options << check_place(*find_pos(place))
    end
    options
  end

  def find_square_indexes(row, column)
    places = []
    start_row = (row / 3) * 3
    start_column = (column / 3) * 3
    (0..2).each do |row_delta|
      (0..2).each do |column_delta|
        new_row = start_row + row_delta
        new_column = start_column + column_delta
        places << find_index([new_row, new_column])
      end
    end
    places
  end

  def compare_square(row, column)
    places = find_square_indexes(row, column)
    options = find_set_options(places)
    singles = compare(options)
    update_from_compare(singles, options, places)
  end

  def compare (options)
    nums=options.flatten.sort
    (1..9).each {|num| nums.delete(num) if nums.count(num)>1}
    nums
  end

  def update_from_compare(singles, options, places)
    singles.each do |num|
      if options.include?(num)
        next
      else
        options.each_with_index do |nums, index|
          next if nums.class == Fixnum
          if nums.include?(num)
            place_index = places[index]
            board[place_index] = num
            @after_guess << find_pos(place_index) if @guessed
          end
        end
      end
    end
  end

  def compare_squares
    (0..2).each do |row|
      (0..2).each do |column|
        compare_square(row*3, column*3)
      end
    end
  end

  def compare_row(row)
    places = (row * 9..(row * 9 + 8)).to_a
    options = find_set_options(places)
    singles = compare(options)
    update_from_compare(singles, options, places)
  end

  def compare_rows
    (0..8).each {|num| compare_row(num)}
  end

  def compare_column(column)
    places = []
    rows = (0..8).to_a
    places = rows.map { |row| find_index([row, column]) }
    options = find_set_options(places)
    singles = compare(options)
    update_from_compare(singles, options, places)
  end

  def compare_columns
    (0..8).each {|num| compare_column(num)}
  end

  def pick_empty
    places_options = {}
    available_places.map { |place| places_options[place] = check_place(*place) }

    @incorrect.each do |set|
      next if places_options[[set[0], set[1]]].nil?
      places_options[[set[0], set[1]]].delete(set[2])
      places_options.delete([set[0], set[1]]) if places_options[[set[0], set[1]]].empty?
    end

    places_options = places_options.sort_by { |key, value| value.length}

    place = places_options.first
    return [*place[0], place[1].first]
  end

  def take_a_guess(nums)
    @guessed = true
    test_case = nums
    @guess << test_case
    @after_guess << ["mg", @guess.length - 1]
    board[find_index(test_case)] = test_case[2]
  end

  def backtrack
    loop do
      break if @after_guess.empty?
      guess = @after_guess.pop
      if guess[0]=="mg"
        guess = @guess.pop
        @incorrect << guess
        board[find_index(guess.take(2))] = 0

        options = check_place(*guess.take(2))
        wrong = @incorrect
          .select { |array| array[0..1] == guess[0..1] }
          .map { |array| array[2] }
        options -= wrong

        if !options.empty?
          break
        end
      else
        board[find_index(guess)] = 0
      end
    end
  end

  def revert
    board = original
  end

  def given
    original.reject { |num| num == 0 }.count
  end

end
