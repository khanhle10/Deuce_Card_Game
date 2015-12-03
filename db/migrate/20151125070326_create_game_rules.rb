class CreateGameRules < ActiveRecord::Migration
  def change
    create_table :game_rules do |t|
      t.integer :round_id
      t.integer :winner_id
      t.integer :position
      t.string :winner_suit

      t.timestamps null: false
    end
  end
end
