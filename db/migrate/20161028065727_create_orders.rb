class CreateOrders < ActiveRecord::Migration[5.0]
  def change
    create_table :orders do |t|
      t.string :receiver_name
      t.string :receiver_address
      t.string :receiver_phone
      t.datetime :delivery_time
      t.text :remarks
      t.integer :order_amount
      t.integer :status
      t.references :user, foreign_key: true

      t.timestamps
    end
    add_index :orders, [:user_id, :created_at]
    change_column :orders, :status, :integer, default: 0
  end
end
