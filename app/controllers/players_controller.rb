class PlayersController < ApplicationController
  def new
    @player = Player.new
  end

  def create
    @player = Player.new(user_params)
    if @player.save!
      session[:id] = @player.id
      redirect_to root_path
    else
      render 'new'
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