Troopr.Routers.TrooprRouter = Backbone.Router.extend({
	initialize: function(options) {
		this.$el = options.$el;
	},

	routes: {
		"": "dashboard",
		"blogs":"blogIndex",
		"blogs/:id":"blogShow",
		"blogs/:id/:post_id":"postShow",
		"session/new":"logIn"
	},
	
	dashboard: function () {
		Troopr.posts.fetch();
		var dashView = new Troopr.Views.PostsIndex({ posts: Troopr.posts });
		this._swapView(dashView);
	},
	blogIndex: function() {},
	blogShow: function() {},
	postShow: function() {},
	logIn: function() {
		var sessionView = new Troopr.Views.LogIn({});
		this._swapView(sessionView);
	},
	
	_swapView: function(view) {
		this._currentView && this._currentView.remove();
		this._currentView = view;
		this.$el.html(view.render().$el);
	}
});