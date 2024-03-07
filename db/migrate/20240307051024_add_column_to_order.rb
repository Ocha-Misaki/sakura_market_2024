class AddColumnToOrder < ActiveRecord::Migration[7.1]
  def change
    add_column :orders, :shipping_fee, :integer, null: false
    add_column :orders, :cash_on_delivery_fee, :integer, null: false
  end
end
