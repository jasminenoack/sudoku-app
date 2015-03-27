Sudoku.Routers.PuzzleRouter = Backbone.Router.extend({
  initialize: function (options) {
    this.$el = options.$el
    this.collection = new Sudoku.Collections.Puzzle
    this.collection.fetch()
  },

  routes: {
    "puzzles/new" : "newForm",
    "puzzles/:id": "showPuzzle",
  },

  newForm: function () {
    var NewView = new Sudoku.Views.Puzzle({
      model: new Sudoku.Models.Puzzle
    })
    this._swapView(NewView)
  },

  showPuzzle: function (id) {
    var model = this.collection.getOrFetch(id)
  },

  _swapView: function (view) {
    if (this.content) {
      this.content.remove()
    }
    this.content = view
    this.$el.html(this.content.render().$el)
  }
})
