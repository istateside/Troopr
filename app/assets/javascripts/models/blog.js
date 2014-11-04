Troopr.Models.Blog = Backbone.Model.extend({
	urlRoot: '/api/blogs',

	posts: function() {
		this._posts = this._posts ||
			new Troopr.Collections.Posts([], { blog: this })
		return this._posts;
	}
});
