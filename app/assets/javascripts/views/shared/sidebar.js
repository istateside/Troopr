Troopr.Views.Sidebar = Backbone.View.extend({
  initialize: function(options) {
    var blogs = Troopr.currentUser.blogs();
    this.listenTo( blogs, 'sync', this.render )
    this.listenTo( Troopr.currentBlog, 'sync', this.render)
  },

  tagName: 'nav',

  className: 'sidebar group',

  events: {
    'click .blog-list-li': 'changeBlog',
    "click a.blog-index-a": "goToIndex",
    "click .blog-list-li.new-blog": "goToNewBlog",
    "click a.new-blog-href": "goToNewBlog"
  },

  template: JST['shared/sidebar'],

  render: function() {
    var content = this.template({});
    this.$el.html(content);
    return this;
  },

  goToNewBlog: function(event) {
    event.preventDefault();
    Backbone.history.navigate('/blogs/new', {trigger: true})
  },
  goToIndex: function(event) {
    event.preventDefault();
    Backbone.history.navigate('/blogs', {trigger: true})
  },

  changeBlog: function(event) {
    var blogID = $(event.currentTarget).data('blog-id')

    if (blogID) {
      $.ajax({
        url: "/api/users/" + Troopr.currentUserID + "/change_blogs",
        type: "POST",
        data: { blog_id: blogID },
        success: function() {
          Troopr.currentBlog = Troopr.currentUser.blogs().getOrFetch(blogID);
          Troopr.currentBlogID = blogID;
          Troopr.currentUser.trigger('switch');
        }
      })
    }
  }
})
