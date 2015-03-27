# Sudoku on Rails

[Live](http://sudoku-on-rails.herokuapp.com/)

This is a single-page app using Backbone and Rails.

# FEATURES

* The app allows you to enter a Sudoku problem.
* The app will solve the Sudoku problem.
* You can then solve the problem yourself.
* You can save the current state of the board.
* You can restart the puzzle at the original state of the board.

# TODO
* hints.

# TECHNOLOGY

* It DRYs up the code by using 2 backbone views for all the pages of the app.
* It lowers the amount of space used in the database by storing the puzzle as a searialized array instead of individual squares. 
* Includes RSpec model tests. 

It uses an algorithm that solves a Sudoku problem in 3 steps.

1. It checks the possible options for a block:

  - The method check_place calls the methods check_row, check_column, and check_square which return what numbers have not been used in the row, column or square associated with the place in the puzzle. It then compares these and returns any numbers that are in all three sets.

  - The method solve_squares calls check_place on every place in the puzzle and enters a number into the puzzle if there is only one possible number that could be in a particular place in the puzzle.

2. It checks the options for all blocks in a row, column, or square:

  - The compare methods create an array of all the options for empty places in the puzzle in a given column, row or square. It then flattens the array to check for any number that can only be placed in one location. If it finds any it will place them in the puzzle in the place they were associated with.

3. It takes a guess based on the possible options:

  - If the puzzle cannot be solved with any of these methods, the computer will make a guess to solve the puzzle. It will attempt to fill the first empty square with a number and will track all additions to the puzzle after that guess. If the puzzle becomes unsolvable it will use backtrack to remove all additions to the puzzle, list it's guess as incorrect and guess the next option for that space. It will continue this until it is able to solve the puzzle.
