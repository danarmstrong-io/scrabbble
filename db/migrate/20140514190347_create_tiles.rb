class CreateTiles < ActiveRecord::Migration
  def change
    create_table :tiles do |t|
      t.string :letter
      t.integer :value
      t.timestamps
    end
  end
end
