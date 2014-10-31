Troopr.Collections.Posts = Backbone.Collection.extend({

  model: Troopr.Models.Post,
	url: '/api/posts/',
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
		}
		return post;
	}

});
