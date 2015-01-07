class Puzzle < ActiveRecord::Base
   serialize :board

  def setup_board(parameters)
    @board=[]
    parameters.each do |param|
        unless param[1]==""
          @board<<param[1].to_i
        else
          @board<<nil
        end
    end
    @board
  end

end
