Troopr.Views.PostsIndex = Backbone.View.extend({
	initialize: function (options) {
		this.posts = options.posts;
		this.listenTo(this.posts, 'sync', this.addPosts);
		this.listenTo( Troopr.currentUser, 'switch', this.switch );
		this.listenTo( Troopr.currentBlog, 'sync', this.loadAvatar);
		this.pageNumber = 1;
	},

	events: {
		"click nav.load-more": "loadMore",
		"click .blogname-link": "goToBlog",
		"click .dash-post-buttons": "showForm",
		"submit .new-post-form": "submitForm",
		"click div.viewport.reblog": "reblogPost",
		"click div.viewport.unliked": "likePost",
		"click div.viewport.liked": "likePost",
		"click button.filepicker": "filepicker",
		"click button.audio.search-btn": "audioSearch",
		"click button.video.search-btn": "videoSearch",
		"click li.search-result-li.audio": "buildAudioPlayer",
		"click li.search-result-li.video": "buildVideoPlayer"
	},

	tagName: 'div',
	className: 'feed group',
  template: JST['posts/index'],
	textForm: JST['forms/text'],
	photoForm: JST['forms/photo'],
	quoteForm: JST['forms/quote'],
	linkForm: JST['forms/link'],
	chatForm: JST['forms/chat'],
	audioForm: JST['forms/audio'],
	videoForm: JST['forms/video'],

	render: function($el) {
		var renderedContent = this.template({
		});
		this.$el.html(renderedContent)

		return this;
	},

	loadAvatar: function(event) {
		this.$('figure.blog-avatar img').attr('src', Troopr.currentBlog.get('filepicker_url'))
	},

	goToBlog: function(event) {
		event.preventDefault();
		var blog_id = $(event.currentTarget).data('id');
		Backbone.history.navigate('blogs/' + blog_id, { trigger: true });
	},

	showForm: function(event) {
		event.preventDefault();
		var dataType = $(event.target).data('content')
		switch (dataType) {
			case "text":
				this.$('.form-space').html(this.textForm());
				break;
			case "photo":
				this.$('.form-space').html(this.photoForm());
				break;
			case "quote":
				this.$('.form-space').html(this.quoteForm());
				break;
			case "link":
				this.$('.form-space').html(this.linkForm());
				break;
			case "chat":
				this.$('.form-space').html(this.chatForm());
				break;
			case "audio":
				this.$('.form-space').html(this.audioForm());
				break;
			case "video":
				this.$('.form-space').html(this.videoForm());
				break;
		}
		if ($('.container').hasClass('active')) {
			if ($(event.target).data('content') == this.$('#input-arrow').attr('class')){
				this.$('.container').removeClass('active')
			}
		} else {
			this.$('.container').addClass('active');
		}
		this.handleArrow($(event.target).data('content'));
	},

	handleArrow: function(contentType) {
		$('#input-arrow').attr('class', contentType);
	},

	submitForm: function(event) {
		event.preventDefault();
		var formData = $(event.target).serializeJSON();
		var that = this;
		var post = this.posts.create(formData, {wait: true});
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
	},

	filepicker: function(event) {
		event.preventDefault();
		filepicker.pick(function(Blob){
			var url = Blob.url;

			this.$('input#image-url').val(url)
		})
	},

	audioSearch: function(event) {
		event.preventDefault();
		var query = this.$('input#audio-search-bar').val();
		var spotifyResp;
		this.spotifySearch(query, function(resp) {
			spotifyResp = resp;
		});
	},

	spotifySearch: function(query, callback) {
		var that = this;
		$.ajax({
			url: "https://api.spotify.com/v1/search",
			data: {
				q: query,
				type: 'track',
				limit: 5
			},
			success: function(resp) {
				var $list = that.$('ul.search-results-list.audio');
				that.$('div.search-results.audio').addClass('active');
				resp.tracks.items.forEach(function(track) {
					var artist = track.artists[0].name;
					var title = track.name;
					var $li = $('<li>').text(artist + " - " + title);

					$li.addClass("search-result-li audio");
					$list.prepend($li);
					var $div = $('<div class="viewport spotify-logo">')
					var $img = $('<img class="spotify-logo sprite" src="' + Troopr.spriteUrl +'">')
					$li.prepend($div);
					$div.prepend($img);

					$li.data('uri', track.uri);
					$li.data('site', "spotify");
				})
			}
		})
	},

	videoSearch: function(event) {
		event.preventDefault();

		var query = this.$('input#video-search-bar').val();
		var that = this;

		$.ajax({
			url: "https://www.googleapis.com/youtube/v3/search",
			data: {
				part: "snippet",
				type: "video",
				key: "AIzaSyDY_1IrjrY6QtfMt-hmD1tkQcJwaH-VgAo",
				q: query
			},

			success: function(resp) {
				var $list = that.$('ul.search-results-list.video');
				that.$('div.search-results.video').addClass('active');
				resp.items.forEach(function(video) {
					var title = video.snippet.title;
					var $li = $('<li>').text(title);

					$li.addClass("search-result-li video");
					$list.prepend($li);

					var url = "http://www.youtube.com/embed/" + video.id.videoId;
					$li.data('url', url);

				})


			}
		})
	},

	buildAudioPlayer: function(event) {
		event.preventDefault()
		var uri = $(event.currentTarget).data('uri');
		var $iframe = this.$('iframe.audio-player.search');
		var src = "https://embed.spotify.com/?uri=" + uri
		$iframe.attr('src', src)
		this.$('iframe.audio-player').slideDown();
		this.$('input#audio-url').val(src);
	},

	buildVideoPlayer: function(event) {
		var url = $(event.currentTarget).data('url');
		var $iframe = this.$('iframe.video-player');
		$iframe.attr('src', url)
		this.$('iframe.video-player').slideDown();
		this.$('input#video-url').val(url);
	},

	switch: function() {
		this.posts.fetch();
		this.render();
	},

	loadMore: function(event) {
		event.preventDefault();
		this.pageNumber++
		var that = this;

		this.posts.fetch({
			data: { page: that.pageNumber },
			processData: true,
			wait: true
		})
	},

	addPost: function(post) {
		postView = new Troopr.Views.PostShow({ post: post, posts: this.posts })
		this.$('.post-list').append(postView.render().$el);
	},

	addPosts: function(resp) {
		var that = this;
		if (resp.models) {
			resp.models.forEach(function(post) {
				that.addPost(post);
			})
		} else {
			var postView = new Troopr.Views.PostShow({ post: resp, posts: this.posts })
			this.$('.post-list').prepend(postView.render().$el);
		}
	}
});
