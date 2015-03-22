window.Sudoku =
  Models: {}
  Collections: {}
  Views: {}
  Routers: {}
  initialize: ->
    new Sudoku.Routers.PuzzleRouter
    Backbone.history.start
    # alert 'Hello from Backbone!'

$(document).ready ->
  Sudoku.initialize()
