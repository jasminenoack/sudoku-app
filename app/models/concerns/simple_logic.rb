module SimpleLogic
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

  def check_place (row, column)
    index = find_index([row, column])
    return board[index] if board[index] != 0
    check_row(row) & check_column(column) & check_square(row, column)
  end

  def check_row(row)
    row = get_row(row)
    check(row)
  end

  def check_column(column)
   column = get_column(column)
   check(column)
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

end
