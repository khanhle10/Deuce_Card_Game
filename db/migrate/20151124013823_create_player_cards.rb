class CreatePlayerCards < ActiveRecord::Migration
  def change
    create_table :player_cards do |t|
      t.integer :player_cards
      t.integer :card_id
      t.integer :card_passing_set_id

      t.timestamps null: false
    end
  end
end
