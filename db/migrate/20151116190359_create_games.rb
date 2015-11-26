class CreateGames < ActiveRecord::Migration
  def change
    create_table :games do |t|
      t.integer :first_winner_id
      t.integer :session_id
      t.string :name, null:false

      t.timestamps null: false
    end
  end
end
