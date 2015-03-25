window.Sudoku =
  Models: {}
  Collections: {}
  Views: {}
  Routers: {}
  initialize: ->
    new Sudoku.Routers.PuzzleRouter({$el: $(".content")})
    Backbone.history.start()

$(document).ready ->
  Sudoku.initialize()
