class CreateOrderProducts < ActiveRecord::Migration[5.0]
  def change
    create_table :order_products do |t|
      t.integer :quantity
      t.integer :price
      t.references :order, foreign_key: true
      t.references :product, foreign_key: true

      t.timestamps
    end
    add_index :order_products, [:order_id, :product_id], unique: true
  end
end
