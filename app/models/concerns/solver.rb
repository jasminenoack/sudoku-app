module Solver
  # base methods to solve the board
  include SimpleLogic
  include ComplexLogic
  include GuessLogic

  def solve_puzzle
    setup_solve_variables
    guess_process
  end

  def setup_solve_variables
    @guessed = false
    @after_guess = []
    @guess =[]
    @incorrect=[]
  end

  def guess_process
    loop do
      if solvable?
        complete_puzzle
        if check_incomplete == 0
          break
        elsif solvable?
          take_a_guess(pick_empty)
          guess_process
          break if check_incomplete == 0
        else
          backtrack
        end
      else
        break
      end
    end
    return board
  end

  def complete_puzzle
    incomplete = check_incomplete
    while incomplete > 0
      start = incomplete
      solve_squares
      incomplete = check_incomplete
      if incomplete == start
        compare_squares
        compare_rows
        compare_columns
        incomplete = check_incomplete
        if incomplete == start
          break
        end
      end
    end
  end
end
