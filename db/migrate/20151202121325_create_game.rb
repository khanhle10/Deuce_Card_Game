class CreateGame < ActiveRecord::Migration
  def change
    create_table :games do |t|
      t.integer :Player1
      t.integer :Player2
      t.integer :Player3
      t.integer :Player4
      t.integer :CurrentHand
      t.integer :LargestCard
      t.integer :CurrentPlayer
    end
  end
end
