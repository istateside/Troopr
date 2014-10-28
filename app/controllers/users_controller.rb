class UsersController < ApplicationController
  def new
    @user = User.new
    render :new
  end

  def create
    @user = User.new(user_params)
    # fail
    if @user.save
      flash[:notice] = ["Account created!"]
      login_user!(@user)
      redirect_to posts_url
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
  
  private
  def user_params
    params.require(:user).permit(:email, :username, :password, :password_confirmation)
  end
end