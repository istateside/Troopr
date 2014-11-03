Troopr.Views.LogIn = Backbone.View.extend({

  template: JST['sessions/new'],
	
	render: function() {
		var content = this.template({user: new Troopr.Models.User()});
		this.$el.html(content);
		return this;
	},
	
	events: {
		'submit .sign-in': 'signIn'
	},
	
	signIn: function (event) {
		event.preventDefault();
		var formData = $(event.target).serializeJSON();
		
		$.ajax({
			url: "/api/session",
			type: "POST",
			data: formData,
			success: function () {
				Troopr.router.navigate("#", { trigger: true })
			}
		})
	}
});
