Troopr.Views.PostsIndex = Backbone.View.extend({
	initialize: function (options) {
		this.posts = options.posts;
		this.listenTo(this.posts, 'sync', this.render);
	},
	
	events: {
		"click #new-post": "showForm",
		"submit .new-post-form": "submitForm"
	},
	
	tagName: 'div',
	
	className: 'feed group',
	
  template: JST['posts/index'],
	
	formTemplate: JST['posts/form'],
	
	render: function($el) {
		var renderedContent = this.template({
		});
		this.$el.html(renderedContent)
		var that = this
		this.posts.each(function(post) {
			postView = new Troopr.Views.PostShow({ post: post })
			that.$('.posts-space').append(postView.render().$el);
		});
		this.$('.posts-space').prepend(this.formTemplate({}));
		return this;
	},
	
	showForm: function(event) {
		event.preventDefault();
		this.$('.new-post-form').toggleClass('active');
	},
	
	submitForm: function(event) {
		event.preventDefault();
		var formData = $(event.target).serializeJSON();
		var that = this;
		this.posts.create(formData, {wait: true})
		this.posts.fetch();
	}
});
