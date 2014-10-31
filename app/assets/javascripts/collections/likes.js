Troopr.Collections.Likes = Backbone.Collection.extend({
  model: Troopr.Models.Like,
	url: '/api/likes/',
	getOrFetch: function(id) {
		var likes = this;
		
		var like;
		if (like = likes.get(id)){
			like.fetch();
		} else {
			like = new Troopr.Models.Like({ id: id });
			like.fetch({
				success: function() { likes.add(like); }
			})
		}
		return like;
	}

});
