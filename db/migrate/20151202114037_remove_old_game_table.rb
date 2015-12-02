class RemoveOldGameTable < ActiveRecord::Migration
  def change
    drop_table :rounds
    drop_table :games
    drop_table :player_rounds
    drop_table :card_passing_sets
  end
end
