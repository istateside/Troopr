Troopr.Views.PostShow = Backbone.View.extend({
	initialize: function (options) {
		this.post = options.post
		this.listenTo(this.post, 'sync', this.render);
	},
	
	events: {
		"click .post-delete": "deletePost",
		"click .like-btn": "likePost",
		"click .reblog-btn": "reblogPost"
	},

	postByline: function() {
		if (this.post.get('reblog')) {
			return (this.post.escape('blogname') + " reblogged this from " + this.post.escape('previous_blogname'));
		} else {
			return (this.post.escape('blogname'));
		}
	},
	
	likePost: function() {
		like = new Troopr.Models.Like 
	},
	
	reblogPost: function() {		
	},
	
	deletePost: function() {
		this.post.destroy();
		this.remove();
	},
	
	tagName: 'div',
	
	className: 'post-box',
  
	template: JST['posts/show'],
	
	render: function(el) {
		var renderedContent = this.template({
			post: this.post,
			byline: this.postByline()
		});
		
		this.$el.html(renderedContent)
		return this;
	}
});
