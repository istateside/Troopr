Troopr.Routers.TrooprRouter = Backbone.Router.extend({
	initialize: function($el) {
		this.$el = $el;
	},
	
	routes: {
		"": "dashboard"
		"/blogs":"blogIndex"
		"/blogs/:id":"blogShow"
		"/blogs/:id/:post_id":"postShow"
	},
	
	dashboard: function () {},
	blogIndex: function() {},
	blogShow: function() {},
	postShow: function() {},
	
	_swapView: function(view) {}
});