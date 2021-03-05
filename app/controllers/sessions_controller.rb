class SessionsController < ApplicationController
  def new
  end

  def create
    @user = User.find_by(name: params[:name])
    if @user
      session[:user_id] = @user.id 
      redirect_to @user
    else
      redirect_to '/login'
    end
  end

  def login
  end

  def welcome
  end

  private

  def user_params
    params.require(:user).permit(:name)
  end
end
