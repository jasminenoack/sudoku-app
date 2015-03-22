class Puzzle < ActiveRecord::Base
  serialize :board
  serialize :original
  serialize :solution

  def blank_board
    board=Array.new(81, 0)
  end

  def create_original
    original={}
      (0..8).each do |square|
        (0..8).each do |place|
          original["#{square}, #{place}"]=send("#{square}, #{place}")
        end
      end
    original
  end

  def switch_board(array = board)
    result=[]
    rows=Array.new
    #selects all rows within a row of squares on the grid
    array.each_slice(27) do |row_set|
      rows=[[],[],[]]
      #selects a square
      row_set.each_slice(9) do |square|
        square.each_with_index do |element, index|
          case index
          when (0..2) then rows[0] << element
          when (3..5) then rows[1] << element
          when (6..8) then rows[2] << element
          end
        end
      end
      result << rows.flatten
    end
    result.flatten
  end

  def create_board
    board=[]
    (0..8).each do |square|
      (0..8).each do |place|
        board<<send("#{square}, #{place}")
      end
    end
    switch_board(board)
  end

  def setup_board
    self.board=create_board.each_slice(9).to_a
  end

  def setup_puzzle
    self.original = create_original
    setup_board
    self.solution = solve_puzzle
  end

  def alter_board
    array = board
    array = array.flatten.map{|x| x=="" ? "0" : x}
    array.each_slice(9).map{|nums| nums.join}.join("\n")
  end

  def revert
    original.each do |place, value|
      self.send("#{place}=",value)
    end
    self.save
  end

  # solving the puzzle

  def solve_puzzle
    # solving_puzzle=Sudoku_Puzzle.new(alter_board)
    solving_puzzle = start_test(alter_board)

    solving_puzzle.guess_process
    solution = switch_board(solving_puzzle.puzzle.flatten)
    index = 0
    solved={}
    (0..8).each do |square|
      (0..8).each do |place|
        solved["#{square}, #{place}"]=solution[index].to_s
        index += 1
      end
    end
    solved
  end

  def start_test(nums)
    puzzle = nums.split("\n")
    @puzzle = []
    @guess = false
    @guesses = []
    @major_guesses =[]
    @incorrect=[]
    puzzle.each{|row| @puzzle << row.split("").map{|num| num=="0" ? "_" : num.to_i}}
    p @puzzle
  end


end


class Sudoku_Puzzle
    attr_accessor :puzzle, :rotated, :guess, :guesses, :major_guesses, :incorrect

    def initialize(nums)
      puzzle=nums.split("\n")
      @puzzle=[]
      @guess = false
      @guesses = []
      @major_guesses =[]
      @incorrect=[]
      puzzle.each{|row| @puzzle << row.split("").map{|num| num=="0" ? "_" : num.to_i}}
      # ["009005071", "500706000", "008490035", "030018200", "090342060", "002960040", "920074300", "000609002", "760800400"]
    end

    def rotate
      @rotated = Array.new(81, "_").each_slice(9).to_a
      (0..8).each do |column|
        (0..8).each do |row|
          @rotated[row][column]=@puzzle[column][row]
        end
      end
      @rotated
    end

    def check(nums)
      possible=[]
      (1..9).each {|num| possible << num if !nums.include?(num) }
      possible
    end

    def check_row(row)
      row=@puzzle[row]
      check(row)
    end

    def check_column(column)
      @rotate=rotate
      column=@rotated[column]
      check(column)
    end

    def find_square(row, column)
      start_h=(((row)/3)*3)
    start_v=(((column)/3)*3)
      square=[]
      (start_h..start_h+2).each do |row|
        (start_v..start_v+2).each do |column|
          square << [row, column]
        end
      end
      square
    end

    def check_square(row, column)
      places=find_square(row, column)
      square=[]
      places.each {|place| square << @puzzle[place[0]][place[1]]}
      check(square)
    end

    def check_place (row, column)
      return @puzzle[row][column] if @puzzle[row][column]!="_"
      check_row(row) & check_column(column) & check_square(row, column)
    end

    def solve_squares
      (0..8).each do |row|
        (0..8).each do |column|
          options=check_place(row, column)
          if options.class==Array && options.length==1
            @puzzle[row][column]=options[0]
            @guesses<<[row, column] if @guess
          end
        end
      end
      self
    end

    def check_incomplete
      incomplete=@puzzle.map {|row| row.count("_")}.inject(:+)
    end

    def find_options(places)
      options=[]
      places.each do |place|
        options << check_place(place[0],place[1])
      end
      options
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
            next if nums.class==Fixnum
            if nums.include?(num)
              row = places[index][0]
              column = places[index][1]
              @puzzle[row][column]=num
              @guesses<< [row, column] if @guess
            end
          end
        end
      end
    end

    def compare_row(row)
      rows=Array.new(9, row)
      columns=(0..8).to_a
      places=rows.zip(columns)
      options=find_options(places)
      singles=compare(options)
      update_from_compare(singles, options, places)
    end

    def compare_rows
      (0..8).each {|num| compare_row(num)}
    end

    def compare_column(column)
      columns=Array.new(9, column)
      rows=(0..8).to_a
      places=rows.zip(columns)
      options=find_options(places)
      singles=compare(options)
      update_from_compare(singles, options, places)
    end

    def compare_columns
      (0..8).each {|num| compare_column(num)}
    end

    def compare_square(row, column)
      places = find_square(row, column)
      options = find_options(places)
      singles = compare(options)
      update_from_compare(singles, options, places)
    end

    def compare_squares
      (0..2).each do |row|
        (0..2).each do |column|
          compare_square(row*3, column*3)
        end
      end
    end

    def complete_puzzle
      incomplete=check_incomplete
      while incomplete>0
        start=incomplete
        solve_squares
        incomplete=check_incomplete
        if incomplete == start
          compare_squares
          compare_rows
          compare_columns
          incomplete=check_incomplete
          if incomplete == start
            break
          end
        end
      end
    end

    def guess_process
      loop do
        if solvable?
          # p solvable? true
          take_a_guess(pick_empty)
          # 2, 3, 4, 6
          complete_puzzle
          if check_incomplete==0
            break
          elsif solvable?
            guess_process
            break if check_incomplete==0
          else
            backtrack
          end
        end

      end

    end

    def pick_empty
      available_places.each do |place|
        options=check_place(*place)
        options.each do |set|
          options.each do |num|
            next if @incorrect.include?([*place,num])
            return [*place, num]
          end
        end
      end
      nil
    end


    def take_a_guess(nums)
      @guess=true
      test_case=nums
      @major_guesses<<test_case
      @guesses<<["mg", @major_guesses.length-1]
      @puzzle[test_case[0]][test_case[1]]=test_case[2]
    end

    def available_places
      open_places=[]
      (0..8).each do |row|
        (0..8).each do |column|
          if @puzzle[row][column]=="_"
            open_places<<[row, column]
          end
        end
      end
      open_places
    end

    def solvable?
      open_places=available_places
      open_places.each do |place|
        if check_place(*place).empty?
          return false
        end
      end
      true
    end

    def backtrack
      loop do
        break if @guesses.empty?
        guess = @guesses.pop
        if guess[0]=="mg" && guess[1]==0
          guess = @major_guesses.pop
          @incorrect << guess
          @puzzle[guess[0]][guess[1]]="_"
        elsif guess[0]=="mg"
          guess=@major_guesses.pop
          @puzzle[guess[0]][guess[1]]="_"
        else
          @puzzle[guess[0]][guess[1]]="_"
        end
      end
    end

  end
