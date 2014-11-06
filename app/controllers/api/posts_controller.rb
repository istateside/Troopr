module Api
  class PostsController < ApiController
    def index
      if !current_blog
        @posts = Post.all
      else
        @posts = current_blog.posts
        current_blog.following.each { |blog| @posts += blog.posts }
      end
      @posts = (@posts.sort_by { |p| p.created_at }).reverse!
      render :index
    end

    def show
      @post = Post.find(params[:id])
      @post.get_notes
      render :show
    end

    def create
      @post = current_blog.posts.new(post_params)

      if @post.post_type == 'video'
        video_id = @post.url.split('v=')[1]
        ampersandPos = video_id.index('&')
        if ampersandPos && ampersandPos != -1
          video_id = video_id[0, ampersandPos]
        end
        @post.url = video_id
      elsif @post.post_type == 'link'
        unless @post.url[0..6] == 'http://' || 'https:/'
          @post.url = "http://" + @post.url
        end
      end
      if @post.save!
        Note.create!({notable_id: @post.id, notable_type: "Post", original_post_id: @post.original_post_id})
        render json: @post
      else
        flash.now[:errors] = @post.errors
        render json: @post.errors.full_messages, status: :unprocessable_entity
      end
    end

    def reblog
      @original_post = Post.find(params[:post_id])

      @new_post = @original_post.dup

      @new_post.reblog = true
      @new_post.previous_blog_id = @original_post.blog_id
      @new_post.blog = current_blog
      @new_post.original_post_id = @original_post.original_post_id
      @new_post.save!

      reblog = @original_post.reblogs.create!({
        new_post_id: @new_post.id,
        blog_id: current_blog.id,
        previous_blog_id: @new_post.previous_blog_id,
        previous_post_id: @original_post.id,
        original_post_id: @original_post.original_post_id
      })

      Note.create!({notable_id: reblog.id, notable_type: "Reblog", original_post_id: @original_post.original_post_id })

      render json: @new_post
    end

    def destroy
      @post = current_blog.posts.find(params[:id])
      @post.try(:destroy)
      render json: {}
    end

    private
    def post_params
      params.require(:post).permit(:title, :body, :post_type, :url)
    end
  end
end
