Troopr.Views.Navbar = Backbone.View.extend({
  initialize: function(options) {
  },

  tagName: 'div',

  className: 'nav-content group',

  events: {
    'click .home-link': 'home'
  },

  template: JST['shared/navbar'],

  home: function () {
    Backbone.history.navigate('#', {trigger: true})
  },

  render: function() {
    var content = this.template({});
    this.$el.html(content);
    return this;
  }
})
