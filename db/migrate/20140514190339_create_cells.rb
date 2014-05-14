class CreateCells < ActiveRecord::Migration
  def change
    create_table :cells do |t|
      t.integer :x_coord
      t.integer :y_coord
      t.timestamps
    end
  end
end
