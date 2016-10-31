class CreateUsers < ActiveRecord::Migration[5.0]
  def change
    create_table :users do |t|
      t.string :email
      t.string :name
      t.string :phone
      t.string :activation_digest
      t.string :password_digest
      t.string :reset_digest
      t.datetime :reset_sent_at
      t.boolean :admin
      t.string :remember_digest
      t.boolean :activated
      t.datetime :activated_at

      t.timestamps
    end
    add_index :users, :email, unique: true
    change_column :users, :admin, :boolean, default: false
    change_column :users, :activated, :boolean, default: false
  end
end
