class CreateTestNames < ActiveRecord::Migration
  def change
    create_table :test_names do |t|
      t.string :name

      t.timestamps null: false
    end
  end
end
