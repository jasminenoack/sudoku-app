class Puzzle < ActiveRecord::Base
  include Solver
  include BoardInfo

  serialize :board
  serialize :original
  serialize :solution

  def board=(board)
    super(board.map(&:to_i))
  end

  def setup_puzzle
    self.original = board
    self.solution = solve_puzzle
    self.board = self.original
    self
  end

  def display
    board.each_slice(9) do |row|
      puts row.join
    end
    nil
  end

  def blank_board
    board=Array.new(81, 0)
  end

  def revert
    board = original
  end

  def given
    original.reject { |num| num == 0 }.count
  end

end
