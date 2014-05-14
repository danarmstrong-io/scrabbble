class CreateGametiles < ActiveRecord::Migration
  def change
    create_table :gametiles do |t|
      t.belongs_to :game
      t.belongs_to :tile
      t.belongs_to :cell
      t.belongs_to :playergame
      t.timestamps
    end
  end
end
