class SessionsController < ApplicationController
  def new
  end

  def create
    @player = Player.authenticate(params[:username], params[:password])
    if @player
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
