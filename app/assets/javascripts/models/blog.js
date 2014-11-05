Troopr.Models.Blog = Backbone.Model.extend({
	urlRoot: '/api/blogs',

	parse: function(resp) {
		if (resp.posts) {
			this.posts().set(resp.posts, { parse: true} );
			delete resp.posts;
		}
		return resp;
	},

	posts: function() {
		this._posts = this._posts ||
			new Troopr.Collections.Posts([], {
				blog: this
			})
		return this._posts;
	}
});
