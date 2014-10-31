window.Troopr = {
  Models: {},
  Collections: {},
  Views: {},
  Routers: {},
  initialize: function() {
		Trooper.posts = new Troopr.Collections.Posts();

		new Troopr.Routers.TrooprRouter({
			"$el": $('main')
		});
		Backbone.History.start();
  }
};

$(document).ready(function(){
  Troopr.initialize();
});
