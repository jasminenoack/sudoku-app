class Api::PuzzlesController < ApplicationController
include PuzzlesHelper

  #creates a hash [square, place in square] => value

  def index
    @puzzles = Puzzle.all
    render json: @puzzles
  end

  def create
    @puzzle = Puzzle.new(puzzle_params)
    @puzzle.setup_puzzle
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

  private

  def puzzle_params
    params.require(:puzzle).permit(board: [])
  end
end
