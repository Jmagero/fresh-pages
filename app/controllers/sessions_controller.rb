class SessionsController < ApplicationController
  def new; end

  def create
    user = User.find_by(name: params[:name])
    if user
      session[:user_id] = user.id
      session[:name] = user.name

      redirect_to root_path, notice: 'Welcome to freshpages!'
    else
      flash.now[:error] = 'Invalid user'
      render :new
    end
  end

  def new
    user = User.new
  end

  def destroy
    session.delete(:user_id)
    session.delete(:name)

    redirect_to root_path, alert: 'See you soon!'
  end
end
