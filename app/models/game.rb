class Game < ActiveRecord::Base
  has_many :playergames
  has_many :players, through: :playergames
  has_many :gametiles
  has_many :cells
  belongs_to :winner, class_name: "Player"


  def self.pending
    Game.all.select{ |game| game.status == "pending" }
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
