class Playergames < ActiveRecord::Base
  belongs_to :player
  belongs_to :games
  has_many :gametiles
  has_many :tiles, through: :gametiles
end
