class OauthCallbacksController < ApplicationController
  def facebook
    @user = User.find_or_create_by_fb_auth_hash(request.env['omniauth.auth'])
    if @user.new_record?
      render 'users/new'
    else
      login_user!(@user)
      redirect_to posts_url
    end
  end
end
