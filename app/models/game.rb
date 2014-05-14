class Game < ActiveRecord::Base
  has_many :playergames
  has_many :gametiles
  has_many :cells
  belongs_to :winner, class_name: "Player"
end
