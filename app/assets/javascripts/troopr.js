window.Troopr = {
  Models: {},
  Collections: {},
  Views: {},
  Routers: {},
  initialize: function() {
    Troopr.currentUser = new Troopr.Models.User({
      id: Troopr.currentUserID
    })
    Troopr.currentUser.fetch({ success: function(){
      Troopr.currentBlog = Troopr.currentUser.blogs().first
    }});
		Troopr.posts = new Troopr.Collections.Posts()
    Troopr.blogs = new Troopr.Collections.Blogs();
		Troopr.router = new Troopr.Routers.TrooprRouter({
			"$nav": $('nav'),
      "$el": $('main')
		});
		Backbone.history.start();
  }
};
