class PuzzlesController < ApplicationController
include PuzzlesHelper

  #creates a hash [square, place in square] => value

  def index
    @puzzles = Puzzle.all
  end

  def new
    @puzzle = Puzzle.new
  end

  def create
    @puzzle=Puzzle.new
    @puzzle.board=@puzzle.blank_board
    @squares=parse_params
    @puzzle.board=@puzzle.update_board(@squares)
    @puzzle.save
    redirect_to puzzle_path(@puzzle.id)
  end

  def show
    find_puzzle
  end

  def edit
    find_puzzle
  end

  def solve
    find_puzzle
  end

  def update
    find_puzzle
    @squares = parse_params
    @puzzle.update_board(@squares)
    @puzzle.save
    if params[:commit]=="Edit"
      redirect_to puzzle_path(@puzzle.id)
    else
      redirect_to :back
    end
  end

  def destroy
    find_puzzle
    @puzzle.destroy
    redirect_to puzzles_path
  end

end



# puzzle board params come in this order if numbered 1-81 left to right top to bottom:
# [1, 2, 3, 10, 11, 12, 19, 20, 21, 4, 5, 6, 13, 14, 15, 22, 23, 24, 7, 8, 9, 16, 17, 18, 25, 26, 27, 28, 29, 30, 37, 38, 39, 46, 47, 48, 31, 32, 33, 40, 41, 42, 49, 50, 51, 34, 35, 36, 43, 44, 45, 52, 53, 54, 55, 56, 57, 64, 65, 66, 73, 74, 75, 58, 59, 60, 67, 68, 69, 76, 77, 78, 61, 62, 63, 70, 71, 72, 79, 80, 81]
