Sudoku.Routers.PuzzleRouter = Backbone.Router.extend({
  initialize: function (options) {
    this.$el = options.$el
    this.collection = new Sudoku.Collections.Puzzles
    this.collection.fetch()
  },

  routes: {
    "puzzles/new" : "newForm",
    "puzzles/:id": "showPuzzle",
    "puzzles/:id/solution": "solutionPuzzle",
    "puzzles/:id/original": "originalPuzzle",
  },

  newForm: function () {
    var NewView = new Sudoku.Views.Puzzle({
      model: new Sudoku.Models.Puzzle,
      board: "board"
    })
    this._swapView(NewView)
  },

  showPuzzle: function (id) {
    var model = this.collection.getOrFetch(id)
    var ShowView = new Sudoku.Views.Puzzle({
      model: model,
      board: "board"
    })
    this._swapView(ShowView)
  },

  solutionPuzzle: function (id) {
    var model = this.collection.getOrFetch(id)
    var SolutionView = new Sudoku.Views.Puzzle({
      model: model,
      board: "solution"
    })
    this._swapView(SolutionView)
  },

  originalPuzzle: function (id) {
    var model = this.collection.getOrFetch(id)
    var originalView = new Sudoku.Views.Puzzle({
      model: model,
      board: "original"
    })
    this._swapView(originalView)
  },

  _swapView: function (view) {
    if (this.content) {
      this.content.remove()
    }
    this.content = view
    this.$el.html(this.content.render().$el)
  }
})
