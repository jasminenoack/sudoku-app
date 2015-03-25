class Api::PuzzlesController < ApplicationController
include PuzzlesHelper

  #creates a hash [square, place in square] => value

  def index
    @puzzles = Puzzle.all
    render json: @puzzles
  end

  def create
    @puzzle = Puzzle.new(puzzle_params)
    if @puzzle.save
      render json: @puzzle
    else
      render json: @puzzle.errors.fullmessages
    end
  end

  def show
    find_puzzle
    render json: @puzzle
  end

  def edit
    # find_puzzle
  end

  def solve
    # find_puzzle
  end

  def update
    # find_puzzle
    # @puzzle.update(puzzle_params)
    # redirect_to action: :solve
  end

  def destroy
    # find_puzzle
    # @puzzle.destroy
    # redirect_to puzzles_path
  end

  def display_original
    # find_puzzle
  end

  def display_solution
    find_puzzle
  end

  def revert_puzzle
    # find_puzzle
    # @puzzle.revert
    # redirect_to puzzle_path(@puzzle.id)
  end

  def puzzle_params
    params.require(:puzzle).permit(board: [])
  end
end
