module Api
  class PostsController < ApiController
    def index
      ids = current_blog.following.pluck(:id) << current_blog.id
      @posts = Post.where(:blog_id => ids).order('created_at DESC').page(params[:page].to_i)
      render :index
    end

    def show
      @post = Post.find(params[:id])
      @post.get_notes
      render :show
    end

    def create
      @post = current_blog.posts.new(post_params)

      if @post.post_type == 'link'
        unless @post.url[0..6] == 'http://' || 'https:/'
          @post.url = "http://" + @post.url
        end
      end
      
      if @post.save!
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
