Troopr.Collections.Posts = Backbone.Collection.extend({
  model: Troopr.Models.Post,

	url: '/api/posts/',

	blog: function () {
		if (!this._blog) {
			this._blog = new Troopr.Models.Blog({
				id: this.blog_id
			})
			this._blog.fetch();
		} else {
			return this._blog;
		}
	},

	getOrFetch: function(id) {
		var posts = this;
		post
		var post;
		if (post = posts.get(id)){
			post.fetch();
		} else {
			post = new Troopr.Models.Post({ id: id });
			post.fetch({
				success: function() { posts.add(post); }
			})
      posts.add(post);
		}
		return post;
	}
});
