class FollowsController < ApplicationController  
  def create
    @follow = current_user.follows.new({target_id: params[:user_id]})
    unless @follow.save!
      flash[:errors] = @follow.errors.full_messages
    end
    redirect_to user_url(User.find(params[:user_id]))
  end
  
  def destroy
    @follow = current_user.follows.find_by_target_id(params[:id])
    @follow.destroy!
    
    redirect_to user_url(User.find(params[:id]))
  end
  
  def index
    @user = User.find(params[:user_id])
    @followed_users = current_user.following
    render :index
  end
end
