class Gametile < ActiveRecord::Base
  belongs_to :game
  belongs_to :tile
  belongs_to :cell
  belongs_to :playergame

  validates :cell_id, presence: true
  before_save {self.tile_id = nil}
end
