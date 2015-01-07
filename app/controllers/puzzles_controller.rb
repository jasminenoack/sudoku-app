class PuzzlesController < ApplicationController

  def parse_params
    squares=[]
    params.each do |item|
      squares<<item if item[0].count(",")>0
    end
    squares
  end


  def new
    @puzzle = Puzzle.new
    @puzzle.board = @puzzle.setup_board
  end

  def create
    @puzzle=Puzzle.new
    @squares=parse_params
    @puzzle.board=@puzzle.setup_board(@squares)
    @puzzle.save
  end

end
