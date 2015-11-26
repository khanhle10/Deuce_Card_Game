class CreateRounds < ActiveRecord::Migration
  def change
    create_table :rounds do |t|
      t.integer :game_id
      t.integer :dealer_id
      t.integer :position, :default => 0
      t.boolean :cards_have_been_passed, :default => false

      t.timestamps null: false
    end
  end
end
