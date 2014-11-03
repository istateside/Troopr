module Api
  class UsersController < ApiController
    def new
      @user = User.new
      render json: @user
    end

    def create
      @user = User.new(user_params)
      if @user.save
        UserMailer.auth_email(@user).deliver!
        render :mailer
      else
        render json: @user.errors.full_messages, status: :unprocessable_entity
      end
    end
    
    def index
      @users = User.all
      render json: @users
    end
  
    def show
      @user = User.find(params[:id])
      render json: @user
    end
  
    def activate
      @user = User.find(params[:user_id])
      if @user.activation_token == params[:activation_token]
        @user.toggle(:activated)
        login_user!(@user)
        render json: ["Account activated!"]
      else
        render json: ["Invalid activation token!"]
      end
    end
  
    def change_blogs
      current_user.current_active_blog = (params[:blog_id])
    end
    
    private
    def user_params
      params.require(:user).permit(:email, :password, :password_confirmation)
    end
  end
end