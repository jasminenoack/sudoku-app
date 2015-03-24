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

  it "can find a column #get_column" do
    expect(puzzle.get_column(2)).to eq([9,0,4,0,0,0,0,1,5])
  end

  it "can find a square #get_square" do
    expect(puzzle.get_square(1,7)).to eq([8,0,0,2,4,9,0,0,0])
  end

  it "can determine what numbers between 1 and 9 are missing from an array #check" do
    expect(puzzle.check([1,4,8,5])).to eq([2,3,6,7,9])
  end

  it "can determine what numbers are not in a column #check_column" do
    expect(puzzle.check_column(2)).to eq([2,3,6,7,8])
  end

  it "can determine what numbers are not in a square #check_square" do
    expect(puzzle.check_square(2,2)).to eq([2,5,6,7,8])
  end

  it "can determine what numbers are not in a row #check_row" do
    expect(puzzle.check_row(5)).to eq([2,6,7,8,9])
  end

  it "can check what could be placed in a particular position #check_place" do
    expect(puzzle.check_place(3,3)).to eq([3,8])
  end

  it "knows if a puzzle is solvable #solvable" do
    expect(puzzle.solvable?).to be true
  end

  it "knows if a puzzle is not solvable #solvable" do
    unsolvable_puzzle = Puzzle.new(board: [
      0,0,9,0,5,0,8,0,9,
      3,0,0,0,1,0,2,4,9,
      0,1,4,9,0,0,0,0,0,
      7,0,0,0,2,9,0,0,4,
      0,4,0,5,0,6,0,8,0,
      5,0,0,1,4,0,0,0,3,
      0,0,0,0,0,1,4,5,0,
      4,8,1,0,9,0,0,0,7,
      0,0,5,0,3,0,1,0,0
    ])
    expect(unsolvable_puzzle.solvable?).to be false
  end

  it "knows what places are open #available_places" do
    available = puzzle.available_places
    expect(available.length).to eq(47)
    expect(available).to include([3,1])
    expect(available).to_not include([3,5])
  end

  it "knows counts incomplete cells #check_incomplete" do
    expect(puzzle.check_incomplete).to eq(47)
  end

  it "knows how to solve squares #solve_squares" do
    puzzle.solve_squares
    expect(puzzle.board).to eq([
      0,0,9,0,5,0,8,0,0,
      3,0,0,0,1,0,2,4,9,
      0,1,4,9,0,0,0,0,0,
      7,0,0,0,2,9,0,0,4,
      0,4,0,5,7,6,9,8,0,
      5,0,0,1,4,8,0,0,3,
      0,0,0,0,0,1,4,5,0,
      4,8,1,0,9,0,0,0,7,
      0,0,5,0,3,0,1,0,0
    ])
  end

  medium_puzzle = Puzzle.new(board: [
    0,0,0,9,0,7,0,0,0,
    9,0,0,0,0,0,0,0,8,
    0,3,0,4,0,5,0,2,0,
    3,0,7,0,4,0,2,0,6,
    0,0,0,5,0,9,0,0,0,
    8,0,9,0,2,0,1,0,3,
    0,7,0,6,0,4,0,3,0,
    2,0,0,0,0,0,0,0,9,
    0,0,0,1,0,2,0,0,0
  ])

  it "knows how to compare within a square"

  it "can compare within all squares"

  it "knows how to compare within a row"
  it "can compare all rows"
  it "knows how to compare within a column"
  it "can compare all columns"

  describe "completes a puzzle" do
    it "solves a simple puzzle" do
      puzzle.complete_puzzle
      expect(puzzle.board).to eq([
        2,7,9,4,5,3,8,6,1,
        3,5,6,8,1,7,2,4,9,
        8,1,4,9,6,2,7,3,5,
        7,6,8,3,2,9,5,1,4,
        1,4,3,5,7,6,9,8,2,
        5,9,2,1,4,8,6,7,3,
        9,3,7,2,8,1,4,5,6,
        4,8,1,6,9,5,3,2,7,
        6,2,5,7,3,4,1,9,8
      ])
    end
    it "solves a puzzle with complex logic"
    it "solves a puzzle that requires guessing"

  end
end

# solve puzzle
# guess process
