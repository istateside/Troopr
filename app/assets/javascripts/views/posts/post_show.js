Troopr.Views.PostShow = Backbone.View.extend({
	initialize: function (options) {
		this.post = options.post;
		this.posts = options.posts;
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

	likePost: function(event) {
		like = new Troopr.Models.Like
	},

	reblogPost: function(event) {
		var that = this;
		event.preventDefault();
		$.ajax({
			url: "/api/posts/" + this.post.id + "/reblog/",
			type: "POST",
			success: function () {
				console.log("Reblogged!");
				that.posts.fetch();
			}
		})
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
