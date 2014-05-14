class SessionsController < ApplicationController
  def new
  end

  def create
    if Player.authenticate(params[:username], params[:password])
      @user = Player.find_by_username(params[:username])
      session[:id] = @user.id
      redirect_to root_path
    else
      render 'new'
    end
  end

  def destroy
    session.clear
    redirect_to root_path
  end
end