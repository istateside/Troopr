Troopr.Collections.Blogs = Backbone.Collection.extend({
  model: Troopr.Models.Blog,
	url: "/api/blogs",
	getOrFetch: function(id) {
		var blogs = this;

		var blog;
		if (blog = blogs.get(id)){
			blog.fetch();
    } else {
			blog = new Troopr.Models.Blog({ id: id });
			blog.fetch({
				success: function() { blogs.add(blog); }
			})
		}
		return blog;
	},

  comparator: 'created_at',


});
