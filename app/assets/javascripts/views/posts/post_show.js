Troopr.Views.PostShow = Backbone.View.extend({
	initialize: function (options) {
		this.post = options.post;
		this.posts = options.posts;

		if (this.post.get('post_type') === "chat") {
			this.parseChat(this.post.escape('body'));
		}

		this.listenTo(this.post, 'sync', this.render);
	},

	events: {
		"click .post-delete": "deletePost",
		"click a.notes-display": "showNotes",
		"click div.viewport.unliked": "likePost",
		"click div.viewport.liked": "likePost"
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

	template: JST['posts/post'],

	showNotes: function(event) {
		event.preventDefault();
		$display = $($(event.target).siblings('div.notes-display'))
		$display.toggleClass('active');
	},

	render: function() {
		var renderedContent = this.template({
			post: this.post,
			byline: this.postByline()
		});

		this.$el.html(renderedContent)

		return this;
	},

	parseChat: function(body) {
		$el = $('<p>')
		var lines = body.replace("\r","").split("\n");
		lines.forEach(function(line) {
			$lineEl = $('<p>').addClass('chatLine');
			var parsedLines = line.match(/(\w+:) (.+)/);
			var speaker = $('<strong>').text(parsedLines[1]);
			var speech = parsedLines[2];
			$lineEl.append(speaker);
			$lineEl.append("\t" + speech);
			$lineEl.append("<br>");
			$el.append($lineEl);
		})
		this.post.set('parsedBody', $el.html());
		return $el
	},

	likePost: function(event) {
		event.preventDefault();
		var id   = $(event.currentTarget).data('post-id');
		var post = this.posts.get(id);
		var that = this;
		$(event.currentTarget).prop('disabled', true)
		var ajaxType = (post.get('is_liked') ? "DELETE" : "POST")
		$.ajax({
			url: "/api/likes",
			type: ajaxType,
			data: { post_id: id },
			success: function() {
				post.fetch();
				$(event.currentTarget).prop('disabled', false);
			}
		})
	}
});
