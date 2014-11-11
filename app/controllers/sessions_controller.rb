class SessionsController < ApplicationController
  def new
    if !!current_user
      redirect_to posts_url
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
    elsif !@user.activated
      UserMailer.auth_email(@user).deliver!
      render :mailer_fail
    else
      login_user!(@user)
      if @user.blogs.empty?
        redirect_to new_blog_url
      else
        redirect_to backbone_url
      end
    end
  end

  def destroy
    logout_user!
    redirect_to new_session_url
  end
  private

  def auth_hash
    request.env['omniauth.auth']
  end
end
