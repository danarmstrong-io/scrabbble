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

  def self.calculate_score(words)
    letters = words.gsub!(/-/, '').split('')
    score = 0
    letters.each do |letter|
      score += Tile.where(letter: letter.upcase).first.value
    end
    score
  end

  def tiles_remaining
    Gametile.where(playergame_id: nil, cell_id: nil, game: self.id).count
  end

  def find_cell_letter(x, y)
    cell = Cell.where(:x_coord => x, :y_coord => y).first
    game_tile = Gametile.where(game: self, cell: cell).first
    game_tile ? game_tile.tile.letter : nil
  end

  def change_turn
    if self.current_player_id == self.players.first.id
      self.current_player_id = self.players.last.id
    else
      self.current_player_id = self.players.first.id
    end
    self.save
  end

  def start
    self.status = 'active'
    self.current_player_id = self.players.first.id
    self.players.each do |player|
      game_tiles = Gametile.where(playergame_id: nil, cell_id: nil, game: self.id).sample(7)
      player_game = Playergame.where(game: self.id, player: player).first
      game_tiles.each do |game_tile|
        game_tile.playergame_id = player_game.id
        game_tile.save
      end
    end
    self.save
  end

  def complete
    self.status = 'completed'
  end
end
