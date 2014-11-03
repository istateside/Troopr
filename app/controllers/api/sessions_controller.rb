module Api
  class SessionsController < ApiController
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
        redirect_to '#'
      end
    end
  
    def destroy
      logout_user!
      redirect_to '#/session/new'
    end
    
    private  
    def auth_hash
      request.env['omniauth.auth']
    end
  end
end