class Playergame < ActiveRecord::Base
  belongs_to :player
  belongs_to :game
  has_many :gametiles
  has_many :tiles, through: :gametiles
end
