window.Troopr = {
  Models: {},
  Collections: {},
  Views: {},
  Routers: {},
  initialize: function() {
    Troopr.currentUser = new Troopr.Models.User({
      id: Troopr.currentUserID
    })

    Troopr.currentUser.fetch();

    Troopr.currentBlog = Troopr.currentUser.blogs().getOrFetch(Troopr.currentBlogID)

		Troopr.posts = new Troopr.Collections.Posts()
    Troopr.blogs = new Troopr.Collections.Blogs();
		Troopr.router = new Troopr.Routers.TrooprRouter({
			"$nav": $('nav'),
      "$el": $('main')
		});
		Backbone.history.start();
  }
};
