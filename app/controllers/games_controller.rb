class GamesController < ApplicationController
  def index
    @games = Game.where(status: "pending")
  end
  def show
    # @game = Game.find(params[:id])
  end
end