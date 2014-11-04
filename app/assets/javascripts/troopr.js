window.Troopr = {
  Models: {},
  Collections: {},
  Views: {},
  Routers: {},
  initialize: function() {
		Troopr.posts = new Troopr.Collections.Posts();
		Troopr.posts.fetch();
    Troopr.blogs = new Troopr.Collections.Blogs();
		Troopr.router = new Troopr.Routers.TrooprRouter({
			"$nav": $('nav'),
      "$el": $('main')
		});
		Backbone.history.start();
  }
};
