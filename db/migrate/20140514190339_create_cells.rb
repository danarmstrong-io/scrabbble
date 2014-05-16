class CreateCells < ActiveRecord::Migration
  def change
    create_table :cells do |t|
      t.integer :x_coord
      t.integer :y_coord
      t.timestamps
    end
		15.times do |row_index|
		  15.times do |col_index|
		    Cell.create!(x_coord: col_index, y_coord: row_index)
		  end
		end 
  end
end
