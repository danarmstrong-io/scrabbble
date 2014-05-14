class CreateGames < ActiveRecord::Migration
  def change
    create_table :games do |t|
      t.string :status
      t.belongs_to :player
      t.timestamps
    end
  end
end
