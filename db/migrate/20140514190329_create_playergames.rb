class CreatePlayergames < ActiveRecord::Migration
  def change
    create_table :playergames do |t|
      t.belongs_to :players
      t.belongs_to :games
      t.integer :score
      t.timestamps
    end
  end
end
