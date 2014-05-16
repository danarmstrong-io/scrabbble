class SessionsController < ApplicationController

  def create
    if Player.authenticate(params[:username], params[:password])
      @player = Player.find_by_username(params[:username])
      session[:id] = @player.id
      redirect_to root_path
    else
      @error = "Please enter correct username/password"
      redirect_to root_path
    end
  end

  def destroy
    session.clear
    redirect_to root_path
  end
end