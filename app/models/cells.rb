class Cells < ActiveRecord::Base
  belongs_to :game
  has_many :gametiles
end
