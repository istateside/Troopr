Troopr.Views.PostsIndex = Backbone.View.extend({
	initialize: function (options) {
		this.posts = options.posts;
		this.listenTo(this.posts, 'add', this.render);
		this.listenTo( Troopr.currentUser, 'switch', this.switch );
		this.listenTo( Troopr.currentBlog, 'sync', this.loadAvatar);
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
	formTemplate: JST['forms/form'],

	render: function($el) {
		var that = this;
		var renderedContent = this.template({
		});
		this.$el.html(renderedContent)

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

	loadAvatar: function(event) {
		this.$('figure.blog-avatar img').attr('src', Troopr.currentBlog.get('filepicker_url'))
	},

	goToBlog: function(event) {
		event.preventDefault();
		var blog_id = $(event.currentTarget).text();
		console.log($(event.currentTarget));
		Backbone.history.navigate('blogs/' + blog_id, { trigger: true });
	},

	showForm: function(event) {
		event.preventDefault();
		var postType = $(event.target).data('content');
		this.$('.form-space').html(this.formTemplate({postType: postType}));
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
		var that = this;
		var formData = $(event.target).serializeJSON();
		var post = this.posts.create(formData, {
			wait: true,
			success: function() {
				post.fetch();
			}
		});

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
	}

});
