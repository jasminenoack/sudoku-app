Sudoku.Views.New = Backbone.View.extend({
  initialize: function () {
  },

  template: JST["sudokuForm"],

  render: function () {
    this.$el.html(this.template())
    return this
  },

})
