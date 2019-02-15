class CreateProducts < ActiveRecord::Migration[5.2]
  def change
    create_table :products do |t|
      t.string :name
      t.boolean :offered
      t.decimal :current_bid
      t.string :image
      t.text :description
      t.decimal :min_price

      t.timestamps
    end
  end
end
