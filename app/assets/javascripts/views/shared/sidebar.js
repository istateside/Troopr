Troopr.Views.Sidebar = Backbone.View.extend({
  initialize: function(options) {
  },

  tagName: 'nav',

  className: 'sidebar group',

  events: {  },

  template: JST['shared/sidebar'],

  render: function() {
    var content = this.template({});
    this.$el.html(content);
    return this;
  }
})
