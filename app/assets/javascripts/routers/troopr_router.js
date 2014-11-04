Troopr.Routers.TrooprRouter = Backbone.Router.extend({
	initialize: function(options) {
		this.$nav = options.$nav;
		this.$el = options.$el;
		this.navBar();
	},

	routes: {
		"": "dashboard",
		"blogs":"blogIndex",
		"blogs/:id":"blogShow",
		"blogs/:id/:post_id":"postShow",
		"session/new":"logIn"
	},
	navBar: function() {
		var navView = new Troopr.Views.Navbar({ $el: this.$nav });
		this.$nav.html(navView.render().$el);
		var that = this;
	},

	dashboard: function () {
		Troopr.posts.fetch();
		var dashView = new Troopr.Views.PostsIndex({ posts: Troopr.posts });
		this._swapView(dashView);

		var sidebar = new Troopr.Views.Sidebar();
		this.$el.append(sidebar.render().$el);
	},

	blogIndex: function() {},

	findBlog: function(event) {
	},

	blogShow: function(blog_id) {
		var blog = Troopr.blogs.getOrFetch(blog_id);

		blog.posts().fetch();

		var showView = new Troopr.Views.BlogsShow({ blog: blog });
		this._swapView(showView);
	},

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
