Sudoku.Routers.PuzzleRouter = Backbone.Router.extend({
  initialize: function (options) {
    this.$el = options.$el
    this.collection = new Sudoku.Collections.Puzzle
    this.collection.fetch()
    console.log("router")
  },

  routes: {
    "puzzles/new" : "newForm",
    "puzzles/:id": "showPuzzle",
  },

  newForm: function () {
    var NewView = new Sudoku.Views.New
    this._swapView(NewView)
  },

  showPuzzle: function (id) {
    console.log("show")
    var model = this.collection.getOrFetch(id)
    console.log(model)
  },

  _swapView: function (view) {
    if (this.content) {
      this.content.remove()
    }
    this.content = view
    this.$el.html(this.content.render().$el)
  }
})
