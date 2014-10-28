class SessionsController < ApplicationController
  def new
    if !!current_user
      redirect_to user_url(current_user)
    else
      @user = User.new
      render :new
    end
  end
  
  def create
    @user = User.find_by_credentials(
      params[:user][:email],
      params[:user][:password]
    )
    
    if @user.nil?
      flash.now[:errors] = ["Email/Password combination not found!"]
      render :new
    else
      login_user!(@user)
      redirect_to posts_url
    end
  end
  
  def destroy
    logout_user!
    redirect_to new_session_url
  end
end