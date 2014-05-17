class Game < ActiveRecord::Base
  has_many :playergames
  has_many :players, through: :playergames
  has_many :gametiles
  belongs_to :winner, class_name: 'Player'
  belongs_to :current_player, class_name: 'Player'

  before_create {self.status = 'pending'}

  def self.pending
    Game.all.select{ |game| game.status == 'pending' }
  end

  def self.dimension
    15
  end

  def find_cell_letter(x, y)
    cell = Cell.where(:x_coord => x, :y_coord => y).first
    game_tile = Gametile.where(game: self, cell: cell).first
    game_tile ? game_tile.tile.letter : nil
  end

  def change_turn
    self.current_player_id == 0 ? self.current_player_id = 1 : self.current_player_id = 0
    if self.current_player_id == self.players.first.id
      self.current_player_id = self.players.last.id
    else
      self.current_player_id = self.players.first.id
    end
  end

  def start
    self.status = 'active'
    self.current_player_id = self.players.first.id
    self.players.each do |player|
      game_tiles = Gametile.where(playergame_id: nil, game: self).sample(7)
      player_game = Playergame.where(game: self, player: player).first
      game_tiles.each do |game_tile|
        game_tile.playergame_id = player_game.id
      end
    end
    self.save
  end

  def complete
    self.status = 'completed'
  end
end
