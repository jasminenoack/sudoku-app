Sudoku.Models.Puzzle = Backbone.Model.extend({
  initialize: function () {
    empty_board = []
    for (var i = 0; i < 81; i++) {
      empty_board.push([0])
    }

    this.set("board", empty_board)
  },

  url: "api/puzzles",

})
