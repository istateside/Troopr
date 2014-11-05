Troopr.Models.Post = Backbone.Model.extend({
	urlRoot: '/api/posts',

	parse: function(resp) {
		if (resp.notes) {
			this.notes().set(resp.notes);
			delete resp.notes;
		}
		return resp;
	},

	notes: function () {
		this._notes = this._notes ||
			new Troopr.Collections.Notes([], {
				post: this
			});
		return this._notes;
	}
});
