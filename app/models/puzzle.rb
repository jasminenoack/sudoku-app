class Puzzle < ActiveRecord::Base
  serialize :board
 


  def blank_board
    board=Array.new(81, 0)
  end

  def update_board(hash)
    hash.each do | place, value |
      board[9*place[0]+place[1]]=value
    end
    board
  end

  def display_board
    switch_board
  end


end




=begin

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

=end