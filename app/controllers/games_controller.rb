class GamesController < ApplicationController
  def index
    @games = Game.where(status: "pending")
    @player = Player.find(session[:id]) if session[:id]
  end

  def create
    @game = Game.create(status: "pending")
    Playergame.create(game: @game, player_id: session[:id], score: 0)
    @tiles = Tile.all
    @tiles.each do |tile|
      Gametile.create(tile: tile, game: @game)
    end
    redirect_to @game
  end

  def join
    @game = Game.find(params[:game_id])
    Playergame.create(game: @game, player_id: session[:id], score: 0)
    @game.status = "active"
    @game.save
    redirect_to @game
  end

  def show
    @player = Player.find(session[:id])
    # @game = Game.find(params[:id])
  end
end