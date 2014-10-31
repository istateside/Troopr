Troopr.Views.PostsIndex = Backbone.View.extend({
	initialize: function (options) {
		this.posts = options.posts
		this.listenTo(this.posts, 'sync', this.render);
	},
	tagName: 'div',
	className: 'feed group',
  template: JST['posts/index'],	
	render: function($el) {
		var renderedContent = this.template({
		});
		this.$el.html(renderedContent)
		var that = this
		this.posts.each(function(post) {
			console.log("Post:", post)
			postView = new Troopr.Views.PostShow({post: post})
			that.$('.posts-space').append(postView.render().$el);
		});
		return this;
	}
});
