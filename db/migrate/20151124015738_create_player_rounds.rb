class CreatePlayerRounds < ActiveRecord::Migration
  def change
    create_table :player_rounds do |t|
      t.integer :player_id
      t.integer :round_id
      
      t.timestamps null: false
    end
  end
end
