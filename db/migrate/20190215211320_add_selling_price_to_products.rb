class AddSellingPriceToProducts < ActiveRecord::Migration[5.2]
  def change
    add_column :products, :selling_price, :integer
  end
end
