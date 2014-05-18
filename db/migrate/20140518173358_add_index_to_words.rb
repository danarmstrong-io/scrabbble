class AddIndexToWords < ActiveRecord::Migration
  def change
  	add_index(:words, :text)
  end
end
