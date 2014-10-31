Troopr.Routers.TrooprRouter = Backbone.Router.extend({
	initialize: function($el) {
		this.$el = options.$el;
	},	
	routes: {
		"": "dashboard"
		"blogs":"blogIndex"
		"blogs/:id":"blogShow"
		"blogs/:id/:post_id":"postShow"
	},	
	dashboard: function () {
		Troopr.posts.fetch();
		var dashView = new Troopr.Views.PostsIndex({ posts: Troopr.posts });
		this.$el.html(dashView.render().$el);
	},
	blogIndex: function() {},
	blogShow: function() {},
	postShow: function() {},
	_swapView: function(view) {}
});