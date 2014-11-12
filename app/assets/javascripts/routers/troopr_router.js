Troopr.Routers.TrooprRouter = Backbone.Router.extend({
	initialize: function(options) {
		this.$nav = options.$nav;
		this.$el = options.$el;
		this.navBar();

		$(document).on('click', function(event) {
			if (!$(event.target).hasClass('notes-display')) {
				$('div.notes-display').removeClass('active')
			}
		})
	},

	routes: {
		"": "dashboard",
		"blogs":"blogIndex",
		"blogs/new": "newBlog",
		"blogs/:id":"blogShow",
		"blogs/:id/edit":"editBlog",
		"login":"logIn"
	},

	navBar: function() {
		var navView = new Troopr.Views.Navbar({ $el: this.$nav });
		this.$nav.html(navView.render().$el);
		var that = this;
	},

	dashboard: function () {
		if (Troopr.currentBlogID) {
			Troopr.posts.fetch();
			var dashView = new Troopr.Views.PostsIndex({ posts: Troopr.posts });
			this._swapView(dashView);
			var sidebar = new Troopr.Views.Sidebar({});
			this.$el.append(sidebar.render().$el);
		} else {
			this.logIn();
		}
	},

	blogIndex: function() {
		Troopr.blogs.fetch();
		var blogIndexView = new Troopr.Views.BlogsIndex();
		this._swapView(blogIndexView);
	},

	newBlog: function () {
		var newBlogView = new Troopr.Views.NewBlog({blog: new Troopr.Models.Blog()});
		this._swapView(newBlogView);
	},

	editBlog: function(id) {
		var blog = Troopr.blogs.get(id)
		var editBlogView = new Troopr.Views.NewBlog({blog: blog})
		this._swapView(editBlogView);
	},

	blogShow: function(blog_id) {
		var blog = Troopr.blogs.getOrFetch(blog_id);
		var showView = new Troopr.Views.BlogsShow({ blog: blog });
		this._swapView(showView);
	},

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
