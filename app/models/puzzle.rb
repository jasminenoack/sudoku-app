class Puzzle < ActiveRecord::Base
  serialize :board
  serialize :original
  serialize :solution

  def board=(board)
    board = board.map(&:to_i)
    super(board)
    self.original = board
    self.solution = solve_puzzle
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
    solution = switch_board(@puzzle.flatten)
    index = 0
    solved={}
    # (0..8).each do |square|
    #   (0..8).each do |place|
    #     solved["#{square}, #{place}"]=solution[index].to_s
    #     index += 1
    #   end
    # end
    solved
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
        # take_a_guess(pick_empty)
        # complete_puzzle
        # if check_incomplete==0
        #   break
        # elsif solvable?
        #   guess_process
        #   break if check_incomplete==0
        # else
        #   backtrack
        # end
      end
    end
  end

  def solvable?
    open_places = available_places
    open_places.each do |place|
      if check_place(*place).empty?
        return false
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




  #
  #
  # def blank_board
  #   board=Array.new(81, 0)
  # end
  #
  #
  #
  # def switch_board(array = board)
  #   result=[]
  #   rows=Array.new
  #   #selects all rows within a row of squares on the grid
  #   array.each_slice(27) do |row_set|
  #     rows=[[],[],[]]
  #     #selects a square
  #     row_set.each_slice(9) do |square|
  #       square.each_with_index do |element, index|
  #         case index
  #         when (0..2) then rows[0] << element
  #         when (3..5) then rows[1] << element
  #         when (6..8) then rows[2] << element
  #         end
  #       end
  #     end
  #     result << rows.flatten
  #   end
  #   result.flatten
  # end
  #
  # def create_board
  #   board=[]
  #   (0..8).each do |square|
  #     (0..8).each do |place|
  #       board<<send("#{square}, #{place}")
  #     end
  #   end
  #   switch_board(board)
  # end
  #
  # def setup_board
  #   self.board=create_board.each_slice(9).to_a
  # end
  #
  #
  #
  # def alter_board
  #   array = board
  #   array = array.flatten.map{|x| x=="" ? "0" : x}
  #   array.each_slice(9).map{|nums| nums.join}.join("\n")
  # end
  #
  # def revert
  #   original.each do |place, value|
  #     self.send("#{place}=",value)
  #   end
  #   self.save
  # end
  #

  #

  #
  # def rotate
  #   @rotated = Array.new(81, "_").each_slice(9).to_a
  #   (0..8).each do |column|
  #     (0..8).each do |row|
  #       @rotated[row][column]=@puzzle[column][row]
  #     end
  #   end
  #   @rotated
  # end
  #

  #

  #
  #
  #
  # def find_square(row, column)
  #
  # end
  #

  #

  #
  # def solve_squares
  #   (0..8).each do |row|
  #     (0..8).each do |column|
  #       options=check_place(row, column)
  #       if options.class==Array && options.length==1
  #         @puzzle[row][column]=options[0]
  #         @after_guess<<[row, column] if @guessed
  #       end
  #     end
  #   end
  #   self
  # end
  #
  # def check_incomplete
  #   incomplete=@puzzle.map {|row| row.count("_")}.inject(:+)
  # end
  #
  # def find_options(places)
  #   options=[]
  #   places.each do |place|
  #     options << check_place(place[0],place[1])
  #   end
  #   options
  # end
  #
  # def compare (options)
  #   nums=options.flatten.sort
  #   (1..9).each {|num| nums.delete(num) if nums.count(num)>1}
  #   nums
  # end
  #
  # def update_from_compare(singles, options, places)
  #   singles.each do |num|
  #     if options.include?(num)
  #       next
  #     else
  #       options.each_with_index do |nums, index|
  #         next if nums.class==Fixnum
  #         if nums.include?(num)
  #           row = places[index][0]
  #           column = places[index][1]
  #           @puzzle[row][column]=num
  #           @after_guess<< [row, column] if @guessed
  #         end
  #       end
  #     end
  #   end
  # end
  #
  # def compare_row(row)
  #   rows=Array.new(9, row)
  #   columns=(0..8).to_a
  #   places=rows.zip(columns)
  #   options=find_options(places)
  #   singles=compare(options)
  #   update_from_compare(singles, options, places)
  # end
  #
  # def compare_rows
  #   (0..8).each {|num| compare_row(num)}
  # end
  #
  # def compare_column(column)
  #   columns=Array.new(9, column)
  #   rows=(0..8).to_a
  #   places=rows.zip(columns)
  #   options=find_options(places)
  #   singles=compare(options)
  #   update_from_compare(singles, options, places)
  # end
  #
  # def compare_columns
  #   (0..8).each {|num| compare_column(num)}
  # end
  #
  # def compare_square(row, column)
  #   places = find_square(row, column)
  #   options = find_options(places)
  #   singles = compare(options)
  #   update_from_compare(singles, options, places)
  # end
  #
  # def compare_squares
  #   (0..2).each do |row|
  #     (0..2).each do |column|
  #       compare_square(row*3, column*3)
  #     end
  #   end
  # end
  #
  # def complete_puzzle
  #   incomplete=check_incomplete
  #   while incomplete>0
  #     start=incomplete
  #     solve_squares
  #     incomplete=check_incomplete
  #     if incomplete == start
  #       compare_squares
  #       compare_rows
  #       compare_columns
  #       incomplete=check_incomplete
  #       if incomplete == start
  #         break
  #       end
  #     end
  #   end
  # end
  #

  #
  # def pick_empty
  #   available_places.each do |place|
  #     options=check_place(*place)
  #     options.each do |set|
  #       options.each do |num|
  #         next if @incorrect.include?([*place,num])
  #         return [*place, num]
  #       end
  #     end
  #   end
  #   nil
  # end
  #
  #
  # def take_a_guess(nums)
  #   @guessed=true
  #   test_case=nums
  #   @guess<<test_case
  #   @after_guess<<["mg", @guess.length-1]
  #   @puzzle[test_case[0]][test_case[1]]=test_case[2]
  # end
  #

  #
  #
  #
  # def backtrack
  #   loop do
  #     break if @after_guess.empty?
  #     guess = @after_guess.pop
  #     if guess[0]=="mg" && guess[1]==0
  #       guess = @guess.pop
  #       @incorrect << guess
  #       @puzzle[guess[0]][guess[1]]="_"
  #     elsif guess[0]=="mg"
  #       guess=@guess.pop
  #       @puzzle[guess[0]][guess[1]]="_"
  #     else
  #       @puzzle[guess[0]][guess[1]]="_"
  #     end
  #   end
  # end

end
