class CreateOrderItems < ActiveRecord::Migration[7.1]
  def change
    create_table :order_items do |t|
      t.references :food, foreign_key: true, null: false
      t.references :order, foreign_key: true, null: false
      t.string :food_name, null: false
      t.integer :food_price, null: false
      t.integer :food_quantity, null: false
      t.timestamps
    end
  end
end
