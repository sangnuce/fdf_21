class CreateProductSuggests < ActiveRecord::Migration[5.0]
  def change
    create_table :product_suggests do |t|
      t.string :name
      t.text :description
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end
