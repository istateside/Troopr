window.Troopr = {
  Models: {},
  Collections: {},
  Views: {},
  Routers: {},
  initialize: function() {
		Troopr.posts = new Troopr.Collections.Posts();
		Troopr.posts.fetch();
		Troopr.router = new Troopr.Routers.TrooprRouter({
			"$el": $('div.backbone')
		});
		Backbone.history.start();
  }
};

$(document).ready(function(){
  Troopr.initialize();
});
