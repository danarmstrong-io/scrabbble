class Cell < ActiveRecord::Base
  belongs_to :game
  has_many :gametiles
end
