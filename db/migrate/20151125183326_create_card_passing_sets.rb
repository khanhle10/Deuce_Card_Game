class CreateCardPassingSets < ActiveRecord::Migration
  def change
    create_table :card_passing_sets do |t|
      t.integer :player_round_id

      t.timestamps null: false
    end
  end
end
