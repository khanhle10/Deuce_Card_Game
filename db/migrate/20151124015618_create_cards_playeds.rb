class CreateCardsPlayeds < ActiveRecord::Migration
  def change
    create_table :cards_playeds do |t|
      t.integer :player_card_id
      
      t.timestamps null: false
    end
  end
end
