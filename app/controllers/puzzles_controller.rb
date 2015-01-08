class PuzzlesController < ApplicationController
  
  #creates a hash [square, place in square] => value
  def parse_params
    squares=[]
    params.each do |item|
      squares<<item if item[0].count(",")>0
    end
    squares=squares.select{|x| x[1]!=""}
    squares=squares.map {|x| [x[0].split(",").map{|num| num.to_i}, x[1].to_i]}.to_h
  end

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
    @puzzle=Puzzle.find(params[:id])
  end
  
  def edit
    @puzzle = Puzzle.find(params[:id])
  end

  def update
    @puzzle = Puzzle.find(params[:id])
    @squares = parse_params
    @puzzle.update_board(@squares)
    @puzzle.save
    redirect_to edit_puzzle_path(@puzzle.id)
  end


end



# puzzle board params come in this order if numbered 1-81 left to right top to bottom: 
# [1, 2, 3, 10, 11, 12, 19, 20, 21, 4, 5, 6, 13, 14, 15, 22, 23, 24, 7, 8, 9, 16, 17, 18, 25, 26, 27, 28, 29, 30, 37, 38, 39, 46, 47, 48, 31, 32, 33, 40, 41, 42, 49, 50, 51, 34, 35, 36, 43, 44, 45, 52, 53, 54, 55, 56, 57, 64, 65, 66, 73, 74, 75, 58, 59, 60, 67, 68, 69, 76, 77, 78, 61, 62, 63, 70, 71, 72, 79, 80, 81]
