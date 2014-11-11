Troopr.Views.LogIn = Backbone.View.extend({

  template: JST['sessions/new'],

	render: function() {
		var content = this.template({user: new Troopr.Models.User()});
		this.$el.html(content);
		return this;
	},

	events: {
		'submit .sign-in-form': 'signIn'
	},

	signIn: function (event) {
		event.preventDefault();
		var formData = $(event.target).serializeJSON();
		$.ajax({
			url: "/api/session",
			type: "POST",
			data: formData,
			success: function (resp) {
        Troopr.currentUserID = resp.id;
        Troopr.currentUser = new Troopr.Models.User({
          id: Troopr.currentUserID
        });
        Troopr.currentUser.fetch();
        Troopr.currentBlogID = resp.current_blog_id;
        Troopr.currentBlog = Troopr.currentUser.blogs().getOrFetch(Troopr.currentBlogID);
        Backbone.history.navigate('')
        Troopr.router.dashboard();
			},
      error: function(resp) {
        console.log(resp);
        window.history.back();
      }
		})
	}
});
