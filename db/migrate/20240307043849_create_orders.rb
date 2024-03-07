class CreateOrders < ActiveRecord::Migration[7.1]
  def change
    create_table :orders do |t|
      t.references :user, foreign_key: true, null: false
      t.string :order_name, default: '', null: false
      t.text :order_address, default: '', null: false
      t.integer :shipping_fee, null: false
      t.integer :cash_on_delivery_fee, null: false
      t.datetime :delivery_at, null: false

      t.timestamps
    end
  end
end
