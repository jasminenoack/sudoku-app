Sudoku.Models.Puzzle = Backbone.Model.extend({
  initialize: function () {
    empty_board = []
    for (var i = 0; i < 81; i++) {
      empty_board.push([0])
    }

    this.set("board", empty_board)
    this.set("solution", empty_board)
    this.set("original", empty_board)
  },

  urlRoot: "api/puzzles",

})
