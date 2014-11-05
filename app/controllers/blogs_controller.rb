class BlogsController < ApplicationController
  def new
    @blog = Blog.new
    render :new
  end

  def create
    @blog = current_user.blogs.new(blog_params)
    if @blog.save!
      flash[:notice] = "Blog registered!"
      redirect_to posts_url
    else
      flash.now[:errors] = @blog.errors.full_messages
      render :new
    end
  end

  def edit
    @blog = current_user.blogs.find(params[:id])
    render :edit
  end

  def update
    @blog = current_user.blogs.find(params[:id])
    if @blog.update!(blog_params)
      flash[:notice] = "Blog updated."
      redirect_to blog_url(@blog)
    else
      flash.now[:errors] = @blog.errors.full_messages
      render :edit
    end
  end

  def destroy
    @blog = current_user.blogs.find(params[:id])
    @blog.destroy!
    redirect_to posts_url
  end

  def show
    @blog = Blog.find(params[:id])
    render :show
  end

  def index
    @blogs = Blog.all
    render :index
  end

  private
  def blog_params
    params.require(:blog).permit(:blogname, :description, :location, :filepicker_url)
  end
end
