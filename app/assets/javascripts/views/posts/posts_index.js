Troopr.Views.PostsIndex = Backbone.View.extend({
	initialize: function (options) {
		this.posts = options.posts;
		this.listenTo(this.posts, 'sync', this.render);
		this.listenTo(this.posts, 'add', this.addPost);
		this.listenTo( Troopr.currentUser, 'switch', this.switch );
	},

	events: {
		"click .dash-post-buttons": "showForm",
		"submit .new-post-form": "submitForm",
		"click div.viewport.reblog": "reblogPost",
		"click div.viewport.unliked": "likePost",
		"click div.viewport.liked": "likePost",
		"click button#filepicker": "filepicker",
		"click a#audio-btn": "audio",
		"click button.search-btn": "search",
		"click li.search-result-li": "buildPlayer"
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
		var that = this
		this.posts.each(function(post) {
			postView = new Troopr.Views.PostShow({ post: post, posts: that.posts })
			that.$('.posts-space').append(postView.render().$el);
		});
		return this;
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
		this.posts.create(formData, { wait: true })
		this.posts.fetch();
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
				post.fetch({success: function(resp) {
						that.posts.add(post);

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

	search: function(event) {
		event.preventDefault();
		query = this.$('input#audio-search-bar').val();
		var soundCloudResp;
		var spotifyResp;
		this.soundCloudSearch(query, function(resp) {
			soundCloudResp = resp;
		});
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
				callback(resp);
				var $list = that.$('ul.search-results-list');
				that.$('div.search-results').addClass('active');
				resp.tracks.items.each(function(track) {
					var artist = track.artists[0].name;
					var title = track.name;
					var $li = $('<li>').text(artist + " - " + title);

					$li.addClass("search-result-li");
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

	soundCloudSearch: function(query, callback) {
		var that = this;
		SC.initialize({client_id: "8529a0b9578d5bf8d5f429e34ec32f53"})
		SC.get('/tracks', { q: query, limit: 5 }, function(resp) {
			callback(resp)
			var $list = that.$('ul.search-results-list');
			that.$('div.search-results').addClass('active');
			_.each(resp, function(track) {
				var $li = $('<li>')
				$li.append(track.title);

				$li.addClass("search-result-li");
				$list.prepend($li);
				var $div = $('<div class="viewport sc-logo">')
				var $img = $('<img class="sc-logo sprite" src="' + Troopr.spriteUrl +'">')
				$li.prepend($div);
				$div.prepend($img);

				$li.data('uri', track.uri);
				$li.data('site', "soundcloud");
			})
		})

	},

	buildPlayer: function(event) {
		var uri = $(event.currentTarget).data('uri');
		var src;
		var $iframe = this.$('iframe.audio-player');
		if  ($(event.target).data('site') === 'spotify') {
			src = "https://embed.spotify.com/?uri=" + uri
		} else {
			src = uri
				+ "&amp;auto_play=false"
				+ "&amp;hide_related=false"
				+ "&amp;show_reposts=false"
				+ "&amp;visual=true"
				+ "&amp;client_id=8529a0b9578d5bf8d5f429e34ec32f53"
		}
		$iframe.attr('src', src)
		this.$('iframe').removeClass('hidden');
		this.$('input#audio-url').val(src);
	},

	switch: function() {
		this.posts.fetch();
	},

	addPost: function(post) {
		postView = new Troopr.Views.PostShow({ post: post, posts: this.posts })
		this.$('.posts-space').prepend(postView.render().$el);
	}
});
