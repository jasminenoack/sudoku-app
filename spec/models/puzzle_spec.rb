require 'rails_helper'
RSpec.describe Puzzle, type: :model do
  puzzle = Puzzle.new(board: [
    0,0,9,0,5,0,8,0,0,
    3,0,0,0,1,0,2,4,9,
    0,1,4,9,0,0,0,0,0,
    7,0,0,0,2,9,0,0,4,
    0,4,0,5,0,6,0,8,0,
    5,0,0,1,4,0,0,0,3,
    0,0,0,0,0,1,4,5,0,
    4,8,1,0,9,0,0,0,7,
    0,0,5,0,3,0,1,0,0
  ])

  it "can find a position from an index: #find_pos" do
    expect(puzzle.find_pos(25)).to eq([2,7])
  end

  it "can find an index from a position: #find_index" do
    expect(puzzle.find_index([2,7])).to eq(25)
  end

  it "can find a row: #get_row" do
    expect(puzzle.get_row(2)).to eq([0,1,4,9,0,0,0,0,0])
  end

  it "can find a column" do
    expect(puzzle.get_column(2)).to eq([9,0,4,0,0,0,0,1,5])
  end

  it "can find a square" do
    expect(puzzle.get_square(1,7)).to eq([8,0,0,2,4,9,0,0,0])
  end

  it "can determine what numbers between 1 and 9 are missing from an array" do
    expect(puzzle.check([1,4,8,5])).to eq([2,3,6,7,9])
  end

  it "can determine what numbers are not in a column" do
    
  end

  it "can determine what numbers are not in a square"
  it "can determine what numbers are not in a row"


  # 0,0,9,0,5,0,8,0,0,
  # 3,0,0,0,1,0,2,4,9,
  # 0,1,4,9,0,0,0,0,0,
  # 7,0,0,0,2,9,0,0,4,
  # 0,4,0,5,0,6,0,8,0,
  # 5,0,0,1,4,0,0,0,3,
  # 0,0,0,0,0,1,4,5,0,
  # 4,8,1,0,9,0,0,0,7,
  # 0,0,5,0,3,0,1,0,0






  it "can check what could be placed in a particular position"


  it "knows if a puzzle is solvable"
  it "knows if a puzzle is not solvable"
  it "can guess what should go into a particular square"
  it "knows what places are open"






  it "saves board, self and solution"


end
