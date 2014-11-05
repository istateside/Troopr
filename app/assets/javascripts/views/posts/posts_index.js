Troopr.Views.PostsIndex = Backbone.View.extend({
	initialize: function (options) {
		this.posts = options.posts;
		this.listenTo(this.posts, 'sync', this.render);
	},

	events: {
		"click .dash-post-buttons": "showForm",
		"submit .new-post-form": "submitForm"
	},

	tagName: 'div',

	className: 'feed group',

  template: JST['posts/index'],

	textTemplate: JST['forms/text'],

	render: function($el) {
		var renderedContent = this.template({
		});
		this.$el.html(renderedContent)
		var that = this
		this.posts.each(function(post) {
			postView = new Troopr.Views.PostShow({ post: post, posts: that.posts })
			that.$('.posts-space').append(postView.render().$el);
		});
		this.$('.posts-space').prepend(this.textTemplate({}));
		return this;
	},

	showForm: function(event) {
		event.preventDefault();

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
	}
});
