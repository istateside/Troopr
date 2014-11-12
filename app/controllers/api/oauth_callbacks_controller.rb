module Api
  class OauthCallbacksController < ApiController
    def facebook
      @user = User.find_or_create_by_fb_auth_hash(request.env['omniauth.auth'])
      if @user.new_record?
        @user.save
        render json: @user
      else
        login_user!(@user)
        redirect_to backbone_url
      end
    end
  end
end
