Troopr.Views.PostShow = Backbone.View.extend({
	initialize: function (options) {
		this.post = options.post
		this.listenTo(this.post, 'sync', this.render);
	},
	
	tagName: 'div',
	
	className: 'post-box',
  
	template: JST['posts/show'],
	postByline: JST['posts/_byline'],
	
	render: function(el) {
		var renderedContent = this.template({
			post: this.post
		});
		
		this.$el.html(renderedContent)
		return this;
	}
});
