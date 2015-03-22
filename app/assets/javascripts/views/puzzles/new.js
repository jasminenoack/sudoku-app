Sudoku.Views.New = Backbone.View.extend({
  initialize: function () {
    this.puzzle = new Sudoku.Models.Puzzle
  },

  template: JST["sudokuForm"],

  events: {
    "submit .puzzle":"newPuzzle",
  },

  render: function () {
    this.$el.html(this.template())
    return this
  },

  newPuzzle: function (event) {
    event.preventDefault()
    event.stopPropagation()
    this.serializePuzzleForm($(event.currentTarget))
    this.puzzle.save()
  },

  serializePuzzleForm: function ($target) {
    board = []
    _($target.children()).each(function (row) {
      board = board.concat(this.readRow($(row)))
    }.bind(this))
    this.puzzle.set("board", board)
  },

  readRow: function ($row) {
    rowValues = []
    _($row.children()).each(function (square) {
      rowValues.push($(square).children()[0].value || 0)
    })
    return rowValues
  },
})
