class AddColumnToOrders < ActiveRecord::Migration[7.1]
  def change
    add_column :orders, :delivery_on, :date, null: false
  end
end
