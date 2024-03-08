class ChangeColumnToOrders < ActiveRecord::Migration[7.1]
  def change
    change_column :orders, :delivery_time, :string, default: '', null: false
  end
end
