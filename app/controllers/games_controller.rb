class GamesController < ApplicationController
  def index
    @games = Game.pending
    @player = Player.find(session[:id]) if session[:id]
  end

  def create
    @game = Game.create
    # CODE REVIEW: this can be done a bit better
    # http://guides.rubyonrails.org/association_basics.html#has-many-association-reference
    Playergame.create(game: @game, player_id: session[:id], score: 0)
    @tiles = Tile.all
    # CODE REVIEW: Same as line 11 for the 16-18
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
      puts params[:words]
      @player_game = Playergame.where(game: @game, player: @game.current_player_id).first
      @player_game.add_to_score(Game.calculate_score(params[:words]))
      @game_tiles = @player_game.gametiles
      input_tiles = params[:tiles].values
      input_tiles.each do |tile|
        @game_tiles.each do |gametile|
          if gametile.tile.letter == tile[:letter]
            @game_tile = gametile
          end
        end
        @game_tile.put_on_board(Cell.where(x_coord: tile[:x], y_coord: tile[:y]).first)
      end
      @player_game.replenish_tiles
      # @game.change_turn
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