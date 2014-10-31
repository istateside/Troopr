Troopr.Collections.Users = Backbone.Collection.extend({

  model: Troopr.Models.User,
	url: '/api/user/',
	getOrFetch: function(id) {
		var user = this;
		
		var user;
		if (user = users.get(id)){
			user.fetch();
		} else {
			user = new Troopr.Models.User({ id: id });
			user.fetch({
				success: function() { users.add(user); }
			})
		}
		return user;
	}

});
