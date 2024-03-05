class CreateFoods < ActiveRecord::Migration[7.1]
  def change
    create_table :foods do |t|
      t.string :name, default: '', null: false
      t.text :description, default: '', null: false
      t.integer :price, null: false
      t.boolean :displayable, default: false, null: false
      t.integer :position, null: false

      t.timestamps
    end
  end
end
