module BoardInfo
  # methods that return information about the board
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

  def find_pos(index)
    row = index / 9
    column = index % 9
    [row, column]
  end

  def find_index(pos)
    pos[0] * 9 + pos[1]
  end

  def get_row(row)
    board[find_index([row, 0])..find_index([row, 8])]
  end

  def get_column(column)
    column_nums = []
    9.times do |i|
      column_nums << board[find_index([i, column])]
    end
    column_nums
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

  def check_incomplete
    board.count(0)
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
end
