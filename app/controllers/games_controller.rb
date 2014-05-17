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
    @game.save
    redirect_to @game
  end

  def show
    @player = Player.find(session[:id])
    @game = Game.find(params[:id])
  end

  def match
    # @game = Game.find(params[:id])
    # params[:words].split('-').all? { |word| !Word.where(text: word).empty? }
    # Verifier(params[:words])
  end

  def submit
    @game = Game.find(params[:id])
    # Add score to player score
    @game.change_turn
  end

  def forfeit
    @game = Game.find(params[:id])
    @game.winner = @game.players.where.not(id: session[:id]).first
    @game.complete
    @game.save
    redirect_to root_path

  end
end