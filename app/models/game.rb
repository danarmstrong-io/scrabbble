class Game < ActiveRecord::Base
  has_many :playergames
  has_many :players, through: :playergames
  has_many :gametiles
  belongs_to :winner, class_name: "Player"
  belongs_to :current_player, class_name: "Player"

  before_create {self.status = "pending"}

  def self.pending
    Game.all.select{ |game| game.status == "pending" }
  end

  def self.dimension
    15
  end

  def find_cell_letter(x, y)
    cell = Cell.where(:x_coord => x, :y_coord => y).first
    puts cell
    gametile = Gametile.where(game: self, cell: cell).first
    puts gametile
    if gametile
      puts gametile.tile.letter
      gametile.tile.letter
    else
      nil
    end
  end
end
