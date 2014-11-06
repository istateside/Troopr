Troopr.Models.User = Backbone.Model.extend({
	urlRoot: '/api/users',

	parse: function(resp) {
		if (resp.blogs) {
			this.blogs().set(resp.blogs, {parse: true} );
			delete resp.blogs;
		}
		return resp;
	},

	blogs: function() {
		this._blogs = this._blogs ||
			new Troopr.Collections.Blogs([], {
				user: this
			})
		return this._blogs;
	}
});
