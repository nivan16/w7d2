class UsersController < ApplicationController
  def new
    @user = User.new
    render :new
  end #this might ne redirect, probably handled in form though

  def show
    @user = User.find_by(params[:id])
    render :show
  end

  def create
    @user = User.create(user_params)
    if @user.save
      redirect_to user_url(@user)
    else
      flash[:errors] = @user.full_message_errors
      render :new
    end
  end

  def destroy
    user = User.find_by(params[:id])
    user.destroy
    redirect_to users_url
  end

  def user_params
    params.require(:user).permit(:email, :password, :session_token)
  end
end