class CreateLobbies < ActiveRecord::Migration
  def change
    create_table :lobbies do |t|
      t.integer :game_id
      t.string  :user_name
      t.integer :game_score
      
      t.timestamps null: false
    end
  end
end
