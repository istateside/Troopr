class FollowsController < ApplicationController
  before_action :check_log_in
  
  def create
    @follow = current_blog.follows.new({target_id: params[:blog_id]})
    unless @follow.save!
      flash[:errors] = @follow.errors.full_messages
    end
    redirect_to blog_url(Blog.find(params[:blog_id]))
  end
  
  def destroy
    @follow = current_blog.follows.find_by_target_id(params[:id])
    @follow.destroy!
    
    redirect_to blog_url(User.find(params[:id]))
  end
end
