Troopr.Views.BlogsIndex = Backbone.View.extend({
  initialize: function(options) {
    this.blogs = new Troopr.Collections.Blogs();
    this.blogs.fetch();
    this.listenTo(this.blogs, 'sync', this.render)
  },

  events: {
    'click .follow-btn': 'follow',
    "click .blogname-link": "goToBlog"
  },

  template: JST['blogs/index'],

  tagName: 'div',
  className: 'blog-index-page',

  render: function () {
    var content = this.template({ blogs: this.blogs });
    this.$el.html(content);
    return this;
  },

  goToBlog: function(event) {
    event.preventDefault();
    var blog_id = $(event.currentTarget).data('id');
    Backbone.history.navigate('blogs/' + blog_id, { trigger: true });
  },

follow: function(event) {
  event.preventDefault();
  var $button = $(event.target);
  $button.prop('disabled', true);
  var that = this;

  var blog = Troopr.blogs.getOrFetch($(event.currentTarget).data('blog-id'))

  if (blog.get('is_followed')) {
    $.ajax({
      url: "/api/follows/" + blog.get('id'),
      type: "DELETE",
      data: { blog_id: blog.get('id') },
      success: function() {
        blog.set({ is_followed: false })
        $button.prop('disabled', false);
        $button.html('Follow')
      }
    })
  } else {
    $.ajax({
      url: "/api/follows/",
      type: "POST",
      data: {blog_id: blog.get('id')},
      success: function () {
        blog.set({ is_followed: true })
        $button.prop('disabled', false);
        $button.html('Unfollow');
      }
    })
  }
}
});
