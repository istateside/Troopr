Troopr.Views.PostShow = Backbone.View.extend({
	initialize: function (options) {
		this.post = options.post;
		this.posts = options.posts;

		if (this.post.get('post_type') === "chat") {
			this.parseChat(this.post.escape('body'));
		}

		this.listenTo(this.post, 'sync', this.render);
		this.listenTo(this.post.notes(), 'remove add', this.renderBottom);
	},

	events: {
		"click .post-delete": "deletePost",
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

	template: JST['posts/post'],

	textTemplate: JST['posts/text'],
	photoTemplate: JST['posts/photo'],
	quoteTemplate: JST['posts/quote'],
	linkTemplate: JST['posts/link'],
	chatTemplate: JST['posts/chat'],
	audioTemplate: JST['posts/audio'],
	videoTemplate: JST['posts/video'],

	showNotes: function(event) {
		event.preventDefault();
		$display = $($(event.target).siblings('div.notes-display'))
		$display.toggleClass('active');
	},

	render: function() {
		// var postType = this.templateType(this.post);

		var renderedContent = this.template({
			post: this.post,
			byline: this.postByline()
			// type: postType
		});

		this.$el.html(renderedContent)

		if (this.post.get('post_type') === "video") {
			this.renderVideoFrame();
		}
		return this;
	},
	//
	// templateType: function(post) {
	// 	switch (post.get('post_type')) {
	// 		case "text":
	// 			return this.textTemplate;
	// 		case "photo":
	// 			return this.photoTemplate;
	// 		case "quote":
	// 			return this.quoteTemplate;
	// 		case "link":
	// 			return this.linkTemplate;
	// 		case "chat":
	// 			return this.chatTemplate;
	// 		case "audio":
	// 			return this.audioTemplate;
	// 		case "video":
	// 			return this.videoTemplate;
	// 	}
	// },

	renderVideoFrame: function() {
		var youtubeID = this.post.get('url');

		var urlString = "//www.youtube.com/embed/" + youtubeID;
		this.$('iframe.player').attr('src', urlString);
	},

	renderSpotifyPlayer: function () {
		var uri =

		this.$('iframe.audio-player').attr('src', uri);
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
	}
});
