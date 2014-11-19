module Api
  class BlogsController < ApiController
    def create
      @blog = current_user.blogs.new(blog_params)
      if @blog.save!
        render :show
      else
        render json: @board.errors.full_messages, status: :unprocessable_entity
      end
    end

    def update
      if @blog.update!(blog_params)
        render :show
      else
        render json: @board.errors.full_messages, status: :unprocessable_entity
      end
    end

    def destroy
      @blog = current_user.blogs.find(params[:id])
      @blog.try(:destroy)
      render json: {}
    end

    def show
      @blog = Blog.friendly.find(params[:id])
    end

    def index
      @blogs = Blog.all
    end

    private
    def blog_params
      params.require(:blog).permit(:blogname, :description, :location)
    end
  end
end
