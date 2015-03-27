Sudoku.Views.Puzzle = Backbone.View.extend({
  initialize: function (options) {
    this.puzzle = new Sudoku.Models.Puzzle
    this.board = options.board
    this.listenTo(this.model, "sync", this.render)
  },

  template: JST["sudokuForm"],

  events: {
    "submit .puzzle":"savePuzzle",
  },

  render: function () {
    this.$el.html(this.template({puzzle: this.model, board: this.board}))
    return this
  },

  savePuzzle: function (event) {
    event.preventDefault()
    event.stopPropagation()
    this.serializePuzzleForm($(event.currentTarget))
    this.puzzle.save()
  },
  // <input value="" type="text" name="square">
  serializePuzzleForm: function ($target) {
    board = []
    _($target.children()).each(function (row) {
      board = board.concat(this.readRow($(row)))
    }.bind(this))
    this.model.set("board", board)
  },

  readRow: function ($row) {
    rowValues = []
    _($row.children()).each(function (square) {
      rowValues.push($(square).children()[0].value || 0)
    })
    return rowValues
  },
})
