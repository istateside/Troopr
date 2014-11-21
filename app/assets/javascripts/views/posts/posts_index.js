Troopr.Views.PostsIndex = Backbone.View.extend({
	initialize: function (options) {
		this.posts = options.posts;
		this.listenTo(this.posts, 'add', this.render);
		this.listenTo( Troopr.currentUser, 'switch', this.switch );
		this.listenTo( Troopr.currentBlog, 'sync', this.loadAvatar);
	},

	events: {
		"click .blogname-link": "goToBlog",
		"click div.viewport.reblog": "reblogPost",
		"click div.viewport.unliked": "likePost",
		"click div.viewport.liked": "likePost"
	},

	tagName: 'div',
	className: 'feed group',
  template: JST['posts/index'],
	formTemplate: JST['forms/form'],

	render: function($el) {
		var that = this;
		var renderedContent = this.template({
		});
		this.$el.html(renderedContent)

		dashView = new Troopr.Views.DashPanel({ posts: this.posts })
		this.$('.dash').append(dashView.render().$el);

		this.posts.forEach(function(post) {
			that.addPost(post);
		})
		this.listenForScroll();
		return this;
	},

	addPost: function(post) {
		postView = new Troopr.Views.PostShow({ post: post, posts: this.posts })

		this.$('.post-list').append(postView.render().$el);
	},

	switch: function() {
		this.posts.fetch();
	},

	listenForScroll: function() {
		$(window).off('scroll');
		var throttledCallback = _.throttle(this.nextPage.bind(this), 200);
		$(window).on('scroll', throttledCallback);
	},

	nextPage: function() {
		var that = this;
		if ($(window).scrollTop() > $(document).height() - $(window).height() - 50) {
			if (that.posts.page_number < that.posts.total_pages) {
				that.posts.fetch({
					data: { page: that.posts.page_number + 1},
					remove: false,
					wait: true
				});
			}
		}
	},

	goToBlog: function(event) {
		event.preventDefault();
		var blog_id = $(event.currentTarget).data('id');
		Backbone.history.navigate('blogs/' + blog_id, { trigger: true });
	},

	reblogPost: function(event) {
		event.preventDefault();
		var id = $(event.currentTarget).data('post-id');
		var that = this;
		$.ajax({
			url: "/api/posts/" + id + "/reblog/",
			type: "POST",
			success: function (resp) {

				var post = new Troopr.Models.Post({id: resp.id})
				post.fetch({silent: true, success: function(resp) {
					postView = new Troopr.Views.PostShow({ post: post, posts: this.posts })
					this.$('.post-list').prepend(postView.render().$el);
				}})
			}
		})
	},

	likePost: function(event) {
		event.preventDefault();
		var id= $(event.currentTarget).data('post-id');
		var post = this.posts.get(id);
		$(event.currentTarget).prop('disabled', true)
		var ajaxType = (post.get('is_liked') ? "DELETE" : "POST")
		$.ajax({
			url: "/api/likes",
			type: ajaxType,
			data: { post_id: id },
			success: function() {
				post.fetch()
				$(event.currentTarget).prop('disabled', false)
			}
		})
	}
});
