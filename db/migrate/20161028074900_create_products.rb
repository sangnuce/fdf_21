class CreateProducts < ActiveRecord::Migration[5.0]
  def change
    create_table :products do |t|
      t.string :name
      t.string :picture
      t.integer :price
      t.integer :quantity
      t.float :rating, default: 0
      t.text :description
      t.integer :status, default: 1
      t.references :category, foreign_key: true

      t.timestamps
    end
    add_index :products, :name, unique: true
  end
end
