class CreateItems < ActiveRecord::Migration
  def change
    create_table :items do |t|
      t.string :title, null: false
      t.string :description, null: false
      t.float :price, null: false
      t.datetime :deadline, null: false
      t.integer :best_bidder_id
      t.timestamps
    end
  end
end
