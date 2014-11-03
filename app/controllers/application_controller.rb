class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  helper_method :current_user, :current_blog

  private
  def login_user!(user)
    session[:session_token] = user.reset_session_token
  end
  
  def check_log_in
    unless !!current_user
      redirect_to new_session_url
    end
  end
  
  def check_blog
    if current_user.blogs.empty?
      redirect_to new_blog_url
    end
  end
  
  def logout_user!
    current_user.reset_session_token
    session[:session_token] = nil
  end
  
  def current_user
    return nil unless session[:session_token]
    @current_user ||= User.find_by_session_token(session[:session_token])
  end
  
  def current_blog
     !!current_user ? current_user.current_active_blog : false
  end
  
  def logged_in?(user)
    session[:session_token] == user.session_token
  end
end
