class CreateLobbies < ActiveRecord::Migration
  def change
    create_table :lobbies do |t|
      t.integer :game_id

      t.timestamps null: false
    end
  end
end
