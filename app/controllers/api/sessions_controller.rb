module Api
  class SessionsController < ApiController
    def create
      @user = User.find_by_credentials(
        params[:user][:email],
        params[:user][:password]
      )
      if @user.nil?
        render json: "Email/Password combination invalid.", status: :unprocessable_entity
      elsif !@user.activated
        UserMailer.auth_email(@user).deliver!
        render :mailer_fail
      else
        login_user!(@user)
        render json: current_user
      end
    end

    def destroy
      logout_user!
      render json: {}
    end

    private
    def auth_hash
      request.env['omniauth.auth']
    end
  end
end
