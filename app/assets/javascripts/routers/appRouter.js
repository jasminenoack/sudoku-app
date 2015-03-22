Sudoku.Routers.PuzzleRouter = Backbone.Router.extend({
  initialize: function (options) {
    this.$el = options.$el
  },

  routes: {
    "new" : "newForm"
  },

  newForm: function () {
    var NewView = new Sudoku.Views.New
    this._swapView(NewView)
  },

  _swapView: function (view) {
    if (this.content) {
      this.content.remove()
    }
    this.content = view
    this.$el.html(this.content.render().$el)
  }
})
