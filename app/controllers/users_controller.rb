class UsersController < ApplicationController
  def new
    @user = User.new
    render :new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      flash[:notice] = "Account created!"
      UserMailer.auth_email(@user).deliver!
      render :mailer
    else
      flash.now[:errors] = @user.errors.full_messages
      render :new
    end
  end
  
  def index
    redirect_to posts_url #CHANGE THIS LATER
  end

  def edit
  end

  def update
  end

  def destroy
  end
  
  def show
    @user = User.find(params[:id])
    render :show
  end
  
  def activate
    @user = User.find(params[:user_id])
    if @user.activation_token == params[:activation_token]
      @user.toggle(:activated)
      login_user!(@user)
      flash[:notice] = "Account activated!"
      redirect_to root_url
    else
      fail
      flash[:errors] = "Activation token did not match!"
      redirect_to new_session_url
    end
  end
  
  private
  def user_params
    params.require(:user).permit(:email, :username, :password, :password_confirmation)
  end
end