class CreateProductImages < ActiveRecord::Migration[5.0]
  def change
    create_table :product_images do |t|
      t.string :image
      t.references :product, foreign_key: true

      t.timestamps
    end
    add_index :product_images, [:product_id, :image], unique: true
  end
end
