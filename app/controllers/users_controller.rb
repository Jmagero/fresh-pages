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

  def show
    @user = obtain_user
    @articles = @user.articles
  end

  def edit
    @user = obtain_user
    redirect_to @user, notice: 'Permission denied' if restrict_user_access
  end

  def update
    @user = obtain_user
    return unless @user.update(user_params)

    session[:name] = @user.name

    redirect_to root_path, notice: 'User updated successfully!'
  end

  def destroy
    @user = obtain_user
    if restrict_user_access
      redirect_to @user, notice: 'Permission denied'
    else
      @user.destroy
      session.delete(:user_id)
      session.delete(:username)
      redirect_to root_path, alert: 'User eliminated!'
    end
  end

  private

  def user_params
    params.require(:user).permit(:name)
  end

  def obtain_user
    User.find(params[:id])
  end

  def restrict_user_access
    user_id = obtain_user.id
    true if session[:user_id] != user_id
  end
end
