Sudoku.Routers.PuzzleRouter = Backbone.routers.extend({
  routes: {
    "#/new" : "NewForm"
  },

  NewForm: function () {
    alert "new"
  }
})
