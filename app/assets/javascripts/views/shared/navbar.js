Troopr.Views.Navbar = Backbone.View.extend({
  initialize: function(options) {
  },

  tagName: 'div',

  className: 'nav-content group',

  events: {
    "click .home-link": "home",
    "click .sign-out-btn": "signOut"
  },

  template: JST['shared/navbar'],

  home: function () {
    event.preventDefault();
    Backbone.history.navigate('#', { trigger: true })
  },

  signOut: function(event) {
    event.preventDefault();
    $.ajax({
      url: "/api/session",
      type: "DELETE",
      success: function() {
        Troopr.currentUserID = null;
        Troopr.currentBlogID = null;
        Troopr.currentUser = null;
        Troopr.currentBlog = null;
        Backbone.history.navigate('/login', { trigger: true })
      }
    })
  },

  render: function() {
    var content = this.template({});
    this.$el.html(content);
    return this;
  }
})
