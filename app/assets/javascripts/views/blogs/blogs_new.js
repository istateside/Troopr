Troopr.Views.NewBlog = Backbone.View.extend({
  initialize: function(options) {
    this.blog = options.blog;
    var that = this;

  },

  events: {
    "click button.filepicker": "filepicker",
    "submit .new-blog-form": "submitForm"
  },

  tagName: 'div',
  className: 'new-blog-page active group',

  template: JST['blogs/form'],

  render: function() {
    var content = this.template({
      blog: this.blog
    });
    this.$el.html(content)
    return this;
  },

  filepicker: function (event) {
    event.preventDefault();
    filepicker.pick(function(Blob){
      var url = Blob.url;

      this.$('input#avatar').val(url);
      this.$('img#avatar-preview').attr('src', url);
      this.$('img#avatar-preview').addClass('active');
    })
  },

  submitForm: function(event) {
    event.preventDefault();
    var formData = $(event.target).serializeJSON();
    Troopr.blogs.create(formData, {
      wait: true,
      success: function(resp) {
        Backbone.history.navigate('', {trigger: true})
      }
    })
  }
})
