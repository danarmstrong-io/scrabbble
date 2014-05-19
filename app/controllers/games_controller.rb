class GamesController < ApplicationController
  def index
    @games = Game.pending
    @player = Player.find(session[:id]) if session[:id]
  end

  def create
    @game = Game.create
    Playergame.create(game: @game, player_id: session[:id], score: 0)
    @tiles = Tile.all
    @tiles.each do |tile|
      Gametile.create(tile: tile, game: @game)
    end
    redirect_to @game
  end

  def join
    @game = Game.find(params[:id])
    Playergame.create(game: @game, player_id: session[:id], score: 0)
    @game.start
    redirect_to @game
  end

  def show
    @player = Player.find(session[:id])
    @game = Game.find(params[:id])
    @playertiles = Playergame.where(player: @player, game: @game).first.gametiles
  end

  def submit
    if Verifier.new(params[:words]).valid?
      @game = Game.find(params[:id])
      @player_game = Playergame.where(game: @game, player: @game.current_player_id).first
      @player_game.take_turn(params[:words])

      @game.put_tiles_on_board_and_change_turn(params[:tiles].values, @player_game.gametiles)
      @player_game.replenish_tiles
      render :json => "true"
    else
      render :json => "false"
    end
  end

  def forfeit
    @game = Game.find(params[:id])
    @game.winner = @game.players.where.not(id: session[:id]).first
    @game.complete
    @game.save
    redirect_to root_path
  end
end