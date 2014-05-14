class CreatePlayergames < ActiveRecord::Migration
  def change
    create_table :playergames do |t|
      t.belongs_to :player
      t.belongs_to :game
      t.integer :score
      t.timestamps
    end
  end
end
