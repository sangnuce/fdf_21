class CreateProducts < ActiveRecord::Migration[5.0]
  def change
    create_table :products do |t|
      t.string :name
      t.string :picture
      t.integer :price
      t.integer :quantity
      t.float :rating
      t.text :description
      t.boolean :status
      t.references :category, foreign_key: true

      t.timestamps
    end
    add_index :products, :name, unique: true
    change_column :products, :status, :boolean, default: 1
  end
end
