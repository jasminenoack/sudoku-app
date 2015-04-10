Sudoku.Views.Puzzle = Backbone.View.extend({
  initialize: function (options) {
    this.board = options.board
    this.listenTo(this.model, "sync", this.render)
  },

  template: JST["sudokuForm"],

  events: {
    "submit .puzzle":"savePuzzle",
    "click .square": "addForm",
    "blur input": "saveInput",
    "click .selectors li": "highlight",
    "keypress input": "disableEnter"
  },

  disableEnter: function (e) {
    if (e.keyCode == 13) {
      e.preventDefault();
      this.saveInput(e)
      return false;
    }
  },

  render: function () {
    this.$el.html(this.template({
      puzzle: this.model,
      board: this.board,
      highlight: this.highlight
      }))
    return this
  },

  savePuzzle: function (event) {
    event.preventDefault()
    event.stopPropagation()
    this.serializePuzzleForm($(event.currentTarget))
    this.model.save({},{
      success: function () {
        this.collection.add(this.model, {merge: true})
        Backbone.history.navigate("puzzles/" + this.model.id, {trigger: true})
      }.bind(this)
    })
  },

  addForm: function (event) {
    event.preventDefault()
    event.stopPropagation()
    if ($(event.currentTarget).hasClass("original")) {
      return
    }
    value = $.trim($(event.currentTarget).text())
    console.log("event", $(event.currentTarget).text())
    $(event.currentTarget).html('<input value="' +
      value +
      '" type="text" name="square">'
    )
    $(event.currentTarget).find("input").focus()
  },

  saveInput: function (event) {
    event.preventDefault()
    var $li = $(event.currentTarget).parent()
    var row = $li.parent().data("row")
    var column =  $li.data("column")
    var num = $(event.currentTarget).val()
    this.model.get("board")[row * 9 + column] = num
    $li.html("<p>" + num + "</p>")
    this.board = "board"
    if (num == this.highlight) {
      $li.addClass("highlight")
    }

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

  highlight: function (event) {
    this.highlight = $(event.target).text()
    this.render()
  },
})
