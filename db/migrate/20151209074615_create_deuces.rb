class CreateDeuces < ActiveRecord::Migration
  def change
    create_table :deuces do |t|
      t.integer :player_count
      t.string :name
      t.string :player1
      t.string :player2
      t.string :player3
      t.string :player4

      t.timestamps null: false
    end
  end
end
