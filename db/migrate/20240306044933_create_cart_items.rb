class CreateCartItems < ActiveRecord::Migration[7.1]
  def change
    create_table :cart_items do |t|
      t.references :cart, foreign_key: true, null: false, index: false
      t.references :food, foreign_key: true, null: false
      t.integer :quantity, null: false

      t.timestamps
    end
  end
end
