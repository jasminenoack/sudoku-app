Sudoku.Collections.Puzzle = Backbone.Collection.extend({
  url: "api/puzzles",

  getOrFetch: function (id) {
    var puzzle = this.get(id)
    if (!puzzle) {
      puzzle = new Sudoku.Models.Puzzle({id: id})
    }
    puzzle.fetch()

    return puzzle
  },
})
