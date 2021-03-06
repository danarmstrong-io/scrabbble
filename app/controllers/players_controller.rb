class PlayersController < ApplicationController
  def new
    @player = Player.new
  end

  def create
    @player = Player.new(user_params)
    if user_params[:username].present? && user_params[:password].present?
      @player.save
      session[:id] = @player.id
      redirect_to root_path
    else
      redirect_to :back
    end
  end

  def show
    @player = Player.find(params[:id])
  end

  private

  def user_params
    params.require(:player).permit(:username, :password)
  end
end