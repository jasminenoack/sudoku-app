Sudoku.Collections.Puzzles = Backbone.Collection.extend({
  url: "api/puzzles",

  model: Sudoku.Models.Puzzle,

  getOrFetch: function (id) {
    var puzzle = this.get(id)

    if (!puzzle) {
      puzzle = new Sudoku.Models.Puzzle({id: id})
      this.add(puzzle)
    }

    puzzle.fetch()

    return puzzle
  },
})
