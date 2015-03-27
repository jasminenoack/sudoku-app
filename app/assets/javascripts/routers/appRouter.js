Sudoku.Routers.PuzzleRouter = Backbone.Router.extend({
  initialize: function (options) {
    this.$el = options.$el
    this.collection = new Sudoku.Collections.Puzzles
    this.collection.fetch()
  },

  routes: {
    "": "index",
    "puzzles/new" : "newForm",
    "puzzles/:id": "showPuzzle",
    "puzzles/:id/solution": "solutionPuzzle",
    "puzzles/:id/original": "originalPuzzle",
  },

  index: function () {
    var indexView = new Sudoku.Views.Index({
      collection: this.collection
    })
    this._swapView(indexView)
  },

  newForm: function () {
    var NewView = new Sudoku.Views.Puzzle({
      model: new Sudoku.Models.Puzzle,
      board: "board",
      collection: this.collection
    })
    this._swapView(NewView)
  },

  showPuzzle: function (id) {
    var model = this.collection.getOrFetch(id)
    var ShowView = new Sudoku.Views.Puzzle({
      model: model,
      board: "board",
      collection: this.collection
    })
    this._swapView(ShowView)
  },

  solutionPuzzle: function (id) {
    var model = this.collection.getOrFetch(id)
    var SolutionView = new Sudoku.Views.Puzzle({
      model: model,
      board: "solution",
      collection: this.collection
    })
    this._swapView(SolutionView)
  },

  originalPuzzle: function (id) {
    var model = this.collection.getOrFetch(id)
    var originalView = new Sudoku.Views.Puzzle({
      model: model,
      board: "original",
      collection: this.collection
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
