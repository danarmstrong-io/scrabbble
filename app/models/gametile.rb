class Gametile < ActiveRecord::Base
  belongs_to :game
  belongs_to :tile
  belongs_to :cell
  belongs_to :playergame

end
