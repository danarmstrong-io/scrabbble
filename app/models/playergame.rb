class Playergame < ActiveRecord::Base
  belongs_to :player
  belongs_to :game
  has_many :gametiles
  has_many :tiles, through: :gametiles

  def draw_tile
    game_tile = Gametile.where(playergame_id: nil, cell_id: nil, game: self.game).sample
    game_tile.playergame_id = self.id
    game_tile.save
  end

  def replenish_tiles
    game_tiles = self.gametiles
    (7-game_tiles.length).times do
      self.draw_tile
    end
  end

  def add_to_score(score)
    self.score += score
    self.save
  end
end

