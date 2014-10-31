Troopr.Views.PostsIndex = Backbone.View.extend({
	initialize: function () {
		this.listenTo(this.posts, 'sync', this.render);
	},
  template: JST['posts/index'],
	
	render: function(el) {
		var renderedContent = this.template({
			posts: this.posts
		});
		
		this.$el.html(renderedContent)
		return this;
	}

});
