Troopr.Views.PostsIndex = Backbone.View.extend({
	initialize: function (options) {
		this.posts = options.posts;
		this.listenTo(this.posts, 'sync', this.render);
	},

	events: {
		"click .dash-post-buttons": "showForm",
		"submit .new-post-form": "submitForm",
		"click .reblog-btn": "reblogPost",
		"click button#filepicker": "filepicker"
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
		console.log(formData);
		var that = this;
		this.posts.create(formData, { wait: true })
		this.posts.fetch();
	},

	reblogPost: function(event) {
		event.preventDefault();
		var id = $(event.target).data('post-id');
		var that = this;
		$.ajax({
			url: "/api/posts/" + id + "/reblog/",
			type: "POST",
			success: function (resp) {
				post = that.posts.getOrFetch(resp.id)

				postView = new Troopr.Views.PostShow({
					post: post, posts: that.posts
				})
				that.$('.posts-space').prepend(postView.render().$el);
			}
		})
	},

	filepicker: function(event) {
		event.preventDefault();
		filepicker.pick(function(Blob){
			var url = Blob.url;

			this.$('input#image-url').val(url)
		})
	}
});
