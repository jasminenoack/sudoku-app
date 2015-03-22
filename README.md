# Sudoku on Rails

[Live](http://sudoku-on-rails.herokuapp.com/)

This began as a rails project last year. The Heroku link is still run completely in rails. Right now I am in the process of moving the frontend into a backbone framework and changing the database structure to use less data.

With this program you can [enter](http://sudoku-on-rails.herokuapp.com/puzzles/new) a Sudoku problem. [View](http://sudoku-on-rails.herokuapp.com/puzzles/1) a problem. View the [solution](http://sudoku-on-rails.herokuapp.com/puzzles/1/display_solution) to a problem. View the [original](http://sudoku-on-rails.herokuapp.com/puzzles/1/display_original) puzzle which was entered. [Solve](http://sudoku-on-rails.herokuapp.com/puzzles/1/solve) the puzzle. Or revert the puzzle back to the original puzzle.

# Current work being done
-[ ] rewriting the puzzle model to use a simplified data structure.
-[ ] creating backbone views to interact with the puzzles
-[ ] writing jQuery to interact with the puzzle.
