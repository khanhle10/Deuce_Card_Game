class RemoveCreateCards < ActiveRecord::Migration
  def change
    #remove the cards table
    drop_table :cards
  end
end
