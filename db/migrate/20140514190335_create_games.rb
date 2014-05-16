class CreateGames < ActiveRecord::Migration
  def change
    create_table :games do |t|
      t.string :status
      t.integer :winner_id
      t.integer :current_player_id
      t.timestamps
    end
  end
end
