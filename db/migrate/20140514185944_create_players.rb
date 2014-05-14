class CreatePlayers < ActiveRecord::Migration
  def change
    create_table :players do |t|
      t.string :username
      t.string :password_digest
      t.string :email
      t.timestamps
    end
  end
end
