Troopr.Views.PostShow = Backbone.View.extend({
	initialize: function (options) {
		this.post = options.post;
		this.posts = options.posts;
		this.listenTo(this.post, 'sync', this.render);
		this.listenTo(this.post.notes(), 'remove add', this.render);
	},

	events: {
		"click .post-delete": "deletePost",
		"click .like-btn": "likePost",
		"click .reblog-btn": "reblogPost",
		"click .blogname-link": "goToBlog",
		"click a.notes-display": "showNotes"
	},

	postByline: function() {
		if (this.post.get('reblog')) {
			return (this.post.escape('blogname') + " reblogged this from " + this.post.escape('previous_blogname'));
		} else {
			return (this.post.escape('blogname'));
		}
	},

	deletePost: function() {
		this.post.destroy();
		this.remove();
	},

	tagName: 'div',

	className: 'post-box',

	template: JST['posts/show'],

	likePost: function(event) {
		event.preventDefault();
		var that = this;
		$(event.target).prop('disabled', true)
		var ajaxType = (that.post.get('is_liked') ? "DELETE" : "POST")
		console.log(that.post);
		console.log(ajaxType);
		$.ajax({
			url: "/api/likes",
			type: ajaxType,
			data: { post_id: that.post.get('id') },
			success: function() {
				that.post.fetch()
				$(event.target).prop('disabled', false)
			}
		})
	},

	reblogPost: function(event) {
		event.preventDefault();
		var that = this;
		$.ajax({
			url: "/api/posts/" + this.post.id + "/reblog/",
			type: "POST",
			success: function () {
				that.posts.fetch();
			}
		})
	},

	goToBlog: function(event) {
		event.preventDefault();
		var blog_id = $(event.target).data('id');
		Backbone.history.navigate('blogs/' + blog_id, { trigger: true });
	},

	showNotes: function(event) {
		event.preventDefault();
		$display = $($(event.target).siblings('div.notes-display'))
		$display.toggleClass('active');
	},

	render: function(el) {
		var renderedContent = this.template({
			post: this.post,
			byline: this.postByline()
		});
		this.$el.html(renderedContent)
		return this;
	}
});
