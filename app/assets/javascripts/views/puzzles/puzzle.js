Sudoku.Views.Puzzle = Backbone.View.extend({
  initialize: function (options) {
    this.board = options.board
    this.listenTo(this.model, "sync", this.render)
  },

  template: JST["sudokuForm"],

  events: {
    "submit .puzzle":"savePuzzle",
    "click .square": "addForm",
    "blur input": "saveInput"
  },

  render: function () {
    this.$el.html(this.template({puzzle: this.model, board: this.board}))
    return this
  },

  savePuzzle: function (event) {
    event.preventDefault()
    event.stopPropagation()
    this.serializePuzzleForm($(event.currentTarget))
    this.model.save()
    this.collection.add(this.model, {merge: true})
  },
  //
  addForm: function (event) {
    event.preventDefault()
    event.stopPropagation()
    if ($(event.currentTarget).hasClass("original")) {
      return
    }
    value = $(event.currentTarget).text()
    $(event.currentTarget).html('<input value="' +
      value +
      '" type="text" name="square">'
    )
    $(event.currentTarget).find("input").focus()
  },

  saveInput: function (event) {
    $(event.currentTarget).replaceWith($(event.currentTarget).val())
  },

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
      rowValues.push($(square).text() || 0)
    })
    return rowValues
  },
})
