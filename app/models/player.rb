class Player < ActiveRecord::Base
  has_many :playergames
  has_many :games, through: :playergames
  has_many :wins, class_name "Game"
end
