class SessionsController < ApplicationController
  def new
  end

  def create
    # CODE REVIEW: you're not using the return value of Player.authenticate
    if Player.authenticate(params[:username], params[:password])
      @player = Player.find_by_username(params[:username])
      session[:id] = @player.id
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