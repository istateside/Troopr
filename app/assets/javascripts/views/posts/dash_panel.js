Troopr.Views.DashPanel = Backbone.View.extend({
  initialize: function() {
    this.listenTo( Troopr.currentBlog, 'sync', this.loadAvatar);
  },

  events: {
    "click ul.dash-post-buttons a.dash-post-link": "showForm",
    "submit .new-post-form": "submitForm",
    "click button.filepicker": "filepicker",
    "click button.audio.search-btn": "audioSearch",
    "click button.video.search-btn": "videoSearch",
    "click li.search-result-li.audio": "buildAudioPlayer",
    "click li.search-result-li.video": "buildVideoPlayer"
  },

  tagName: 'div',
  className: 'dashboard group',
  template: JST['posts/dash_panel'],
  formTemplate: JST['forms/form'],

  render: function($el) {
    var renderedContent = this.template();
    this.$el.html(renderedContent)
    return this;
  },

  loadAvatar: function(event) {
    this.$('figure.blog-avatar img').attr('src', Troopr.currentBlog.get('filepicker_url'))
  },

  showForm: function(event) {
    event.preventDefault();
    var $link = $(event.currentTarget);
    var postType = $link.data('content');
    var modalCover = $('div.cover');
    this.$('.form-space').html(this.formTemplate({postType: postType}));
    if ($('.container').hasClass('active')) {
      if (postType == this.$('#input-arrow').attr('class')){
        this.$('.container').removeClass('active')
        modalCover.removeClass('active');
      }
    } else {
      this.$('.container').addClass('active');
      modalCover.addClass('active');
    }
    this.handleArrow(postType);
  },

  handleArrow: function(contentType) {
    $('#input-arrow').attr('class', contentType);
  },

  submitForm: function(event) {
    event.preventDefault();
    var that = this;
    var formData = $(event.target).serializeJSON();
    var post = this.posts.create(formData, {
      wait: true,
      success: function() {
        post.fetch();
      }
    });

  },

  filepicker: function(event) {
    event.preventDefault();
    filepicker.pick(function(Blob){
      var url = Blob.url;

      this.$('input#image-url').val(url)
    })
  },

  audioSearch: function(event) {
    event.preventDefault();
    var query = this.$('input#audio-search-bar').val();
    var spotifyResp;
    this.spotifySearch(query, function(resp) {
      spotifyResp = resp;
    });
  },

  spotifySearch: function(query, callback) {
    var that = this;
    $.ajax({
      url: "https://api.spotify.com/v1/search",
      data: {
        q: query,
        type: 'track',
        limit: 5
      },
      success: function(resp) {
        var $list = that.$('ul.search-results-list.audio');
        that.$('div.search-results.audio').addClass('active');
        resp.tracks.items.forEach(function(track) {
          var artist = track.artists[0].name;
          var title = track.name;
          var $li = $('<li>').text(artist + " - " + title);

          $li.addClass("search-result-li audio");
          $list.prepend($li);
          var $div = $('<div class="viewport spotify-logo">')
          var $img = $('<img class="spotify-logo sprite" src="' + Troopr.spriteUrl +'">')
          $li.prepend($div);
          $div.prepend($img);

          $li.data('uri', track.uri);
          $li.data('site', "spotify");
        })
      }
    })
  },

  videoSearch: function(event) {
    event.preventDefault();

    var query = this.$('input#video-search-bar').val();
    var that = this;

    $.ajax({
      url: "https://www.googleapis.com/youtube/v3/search",
      data: {
        part: "snippet",
        type: "video",
        key: "AIzaSyDY_1IrjrY6QtfMt-hmD1tkQcJwaH-VgAo",
        q: query
      },

      success: function(resp) {
        var $list = that.$('ul.search-results-list.video');
        that.$('div.search-results.video').addClass('active');
        resp.items.forEach(function(video) {
          var title = video.snippet.title;
          var $li = $('<li>').text(title);

          $li.addClass("search-result-li video");
          $list.prepend($li);

          var url = "http://www.youtube.com/embed/" + video.id.videoId;
          $li.data('url', url);

        })


      }
    })
  },

  buildAudioPlayer: function(event) {
    event.preventDefault()
    var uri = $(event.currentTarget).data('uri');
    var $iframe = this.$('iframe.audio-player.search');
    var src = "https://embed.spotify.com/?uri=" + uri
    $iframe.attr('src', src)
    this.$('iframe.audio-player').slideDown();
    this.$('input#audio-url').val(src);
  },

  buildVideoPlayer: function(event) {
    var url = $(event.currentTarget).data('url');
    var $iframe = this.$('iframe.video-player');
    $iframe.attr('src', url)
    this.$('iframe.video-player').slideDown();
    this.$('input#video-url').val(url);
  }
});
