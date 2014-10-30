class PostsController < ApplicationController
  before_action :check_log_in, :check_blog
  def index
    @posts = current_blog.posts
    current_blog.following.each do |blog|
      @posts += blog.posts
    end
    @posts = (@posts.sort_by {|p| p.created_at }).reverse!
    render :index
  end

  def new
    @post = Post.new
    render :new
  end

  def create
    @post = current_blog.posts.new(post_params)
    @post.post_type = "text" # CHANGE THIS LATER!
    if @post.save!
      flash[:notice] = "Post saved."
      redirect_to posts_url
    else
      flash.now[:errors] = @post.errors
      render :new
    end
  end

  def show
    @post = Post.find(params[:id])
    @post.get_note_path
    render :show
  end
  
  def reblog
    @original_post = Post.find(params[:post_id])
    @reblog = @original_post.dup
    @reblog.reblog = true
    @reblog.previous_blog_id = @original_post.blog_id
    @reblog.blog = current_blog
    @reblog.original_blog_id = @original_post.id
  
    @reblog.save!
    Reblog.create!({ post_id: @original_post.id, blog_id: current_blog.id, previous_blog_id: @reblog.previous_blog_id })
    redirect_to posts_url
  end

  private

  def post_params
    params.require(:post).permit(:title, :body, :post_type)
  end
end