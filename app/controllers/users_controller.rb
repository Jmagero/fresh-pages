class UsersController < ApplicationController
  def new
    @user = User.new
  end

  def create
    @user = User.create(user_params)
    if @user.save
      flash[:success] = "Welcome to Fresh pages"
      redirect_to @user
    else
      render new
    end
  end


  private

  def user_params
    params.require(:user).permit(:name)
  end
end
