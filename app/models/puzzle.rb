class Puzzle < ActiveRecord::Base
  serialize :board

  #switches between display array and working array
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

  def setup_board(parameters)
    @board=switch_board(parameters)
  end

  def display_board
    switch_board
  end


end
