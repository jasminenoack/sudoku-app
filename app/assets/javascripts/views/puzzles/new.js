Sudoku.Views.New = Backbone.View.extend({
  initialize: function () {
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
    this.board = this.serializePuzzleForm($(event.currentTarget))
    console.log("board", board)
  },

  serializePuzzleForm: function ($target) {
    board = []
    _($target.children()).each(function (row) {
      board = board.concat(this.readRow($(row)))
    }.bind(this))
    return board
  },

  readRow: function ($row) {
    rowValues = []
    _($row.children()).each(function (square) {
      rowValues.push($(square).children()[0].value || 0)
    })
    return rowValues
  },
})
