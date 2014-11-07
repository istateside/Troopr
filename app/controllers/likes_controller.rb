class LikesController < ApplicationController
  before_action :check_log_in
  def create
    post = Post.find(params[:post_id])
    like = current_blog.likes.create!({post: post, original_post_id: post.original_post_id})
    Note.create!({original_post_id: post.original_post_id, notable_id: like.id, notable_type: "Like"})
    redirect_to (:back)
  end

  def destroy
    @like = current_blog.likes.find(params[:id])
    !!@like ? @like.destroy! : flash[:errors] = ["Like not found."]
    redirect_to (:back)
  end
end
