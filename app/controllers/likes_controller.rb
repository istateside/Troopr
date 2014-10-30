class LikesController < ApplicationController
  before_action :check_log_in
  def create
    post = Post.find(params[:post_id])
    current_blog.likes.create!({post: post})
    redirect_to posts_url
  end
  
  def destroy
    @like = current_blog.likes.find(params[:id])
    !!@like ? @like.destroy! : flash[:errors] = ["Like not found."]
    redirect_to posts_url
  end
end