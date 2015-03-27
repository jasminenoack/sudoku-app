Sudoku.Views.Index = Backbone.View.extend({
  initialize: function (options) {
    this.listenTo(this.collection, "sync", this.render)
  },

  template: JST["index"],

  render: function () {
    this.$el.html(this.template({puzzles: this.collection}))
    return this
  },

})
