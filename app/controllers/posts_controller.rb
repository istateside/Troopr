class PostsController < ApplicationController
  before_action :check_log_in
  def index
    @posts = current_user.posts
    current_user.following.each do |user|
      @posts += user.posts
    end
    @posts = (@posts.sort_by {|p| p.created_at }).reverse!
    render :index
  end

  def new
    @post = Post.new
    render :new
  end

  def create
    @post = current_user.posts.new(post_params)
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
    @reblog.previous_user_id = @original_post.user_id
    @reblog.user = current_user
    @reblog.original_post_id = @original_post.id
  
    @reblog.save!
    Reblog.create!({ post_id: @original_post.id, user_id: current_user.id, previous_user_id: @reblog.previous_user_id })
    redirect_to posts_url
  end

  private

  def post_params
    params.require(:post).permit(:title, :body, :post_type)
  end
end