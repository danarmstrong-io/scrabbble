class Gametiles < ActiveRecord::Base
  belongs_to :game
  belongs_to :tile
  belongs_to :cell
  belongs_to :playergames
end
