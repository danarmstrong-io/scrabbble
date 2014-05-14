class CreateCells < ActiveRecord::Migration
  def change
    create_table :cells do |t|
      t.belongs_to :game
      t.integer :x_coord
      t.integer :y_coord
      t.timestamps
    end
  end
end
