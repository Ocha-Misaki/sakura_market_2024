class ChangeColumnsToOrders < ActiveRecord::Migration[7.1]
  def change
    rename_column :orders, :delivery_at, :delivery_time
  end
end
