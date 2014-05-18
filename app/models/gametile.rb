class Gametile < ActiveRecord::Base
  belongs_to :game
  belongs_to :tile
  belongs_to :cell
  belongs_to :playergame

  def put_on_board(cell)
    self.playergame_id = nil
    self.cell_id = cell.id
    self.save
  end
end
