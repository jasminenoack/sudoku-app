module PuzzlesHelper

  def parse_params
    squares=[]
    params.each do |item|
      squares<<item if item[0].count(",")>0
    end
    squares=squares.select{|x| x[1]!=""}
    squares=squares.map {|x| [x[0].split(",").map{|num| num.to_i}, x[1].to_i]}.to_h
  end

  def find_puzzle
    @puzzle=Puzzle.find(params[:id])
  end

end
