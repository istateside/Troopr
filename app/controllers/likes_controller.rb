class LikesController < ApplicationController
  before_action :check_log_in
  def create
    current_user.likes.create!({post: Post.find(params[:post_id])})
    redirect_to posts_url
  end
  
  def destroy
    @like = current_user.likes.find(params[:id])
    !!@like ? @like.destroy! : flash[:errors] = ["Like not found."]
    redirect_to posts_url
  end
end