Troopr.Collections.Sessions = Backbone.Collection.extend({
  model: Troopr.Models.Session,
	url: '/api/sessions/',
	getOrFetch: function(id) {
		var follows = this;
		
		var follow;
		if (follow = follows.get(id)){
			follow.fetch();
		} else {
			follow = new Troopr.Models.Follow({ id: id });
			follow.fetch({
				success: function() { follows.add(follow); }
			})
		}
		return follow;
	}
});
