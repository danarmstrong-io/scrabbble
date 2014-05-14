class PlayersController < ApplicationController
  def new
    @player = Player.new
  end

  def create
    @player = Player.new(user_params)
    if @player.save!
      redirect_to root_path
    else
      render 'new'
    end
  end

  private

  def user_params
    params.require(:user).permit(:username, :password)
  end
end