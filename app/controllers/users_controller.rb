class UsersController < ApplicationController
  def new
    @user = User.new
  end

  def create
    @user = User.create(user_params)
    if @user.valid?
      @user.save

      session[:user_id] = @user.id
      session[:name] = @user.name

      redirect_to root_path, notice: "#{session[:name]} you were successfully created"
    else
      render 'new'
    end
  end

  private

  def user_params
    params.require(:user).permit(:name)
  end
end
