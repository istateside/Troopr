Troopr.Collections.Notes = Backbone.Collection.extend({
  model: Troopr.Models.Note,
	url: '/api/notes/',
	getOrFetch: function(id) {
		var notes = this;
		
		var note;
		if (note = notes.get(id)){
			note.fetch();
		} else {
			note = new Troopr.Models.Note({ id: id });
			note.fetch({
				success: function() { notes.add(note); }
			})
		}
		return note;
	}

});
