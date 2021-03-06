Troopr.Views.BlogsShow = Backbone.View.extend({
  initialize: function(options) {
    this.blog = options.blog;
    blog = options.blog;
    this.listenTo(this.blog, 'sync', this.render);
    this.listenTo(this.blog.posts(), 'sync', this.render);
  },

  tagName: 'blogDiv',
  className: 'feed group',
  template: JST['blogs/show'],

  events: {
    'click .follow-btn': 'follow'
  },

  render: function() {
    var content = this.template({blog: this.blog});
    this.$el.html(content);
    var that = this;
    this.blog.posts().each(function(post) {
      var postView = new Troopr.Views.PostShow({
        post: post,
        blog: that.blog,
        id: post.id
      })

      that.$('.posts-space').append(postView.render().$el);
    });

    if(this.blog.posts().length === 0) {
      that.$('.posts-space').html(
        "<div class='post-box'><div class='post-content'>No posts have been found for this blog!</div></div>"
      )
    }

    return this;
  },

  follow: function(event) {
    event.preventDefault();
    var $button = $(event.target);
    $button.prop('disabled', true);
    var that = this;
    if (that.blog.get('is_followed')) {
      $.ajax({
        url: "/api/follows/" + that.blog.get('id'),
        type: "DELETE",
        data: { blog_id: that.blog.get('id') },
        success: function() {
          that.blog.set({ is_followed: false })
          $button.prop('disabled', false);
          $button.html('Follow')
        }
      })
    } else {
      $.ajax({
        url: "/api/follows/",
        type: "POST",
        data: {blog_id: that.blog.get('id')},
        success: function () {
          that.blog.set({ is_followed: true })
          $button.prop('disabled', false);
          $button.html('Unfollow');
        }
      })
    }
  }
});
