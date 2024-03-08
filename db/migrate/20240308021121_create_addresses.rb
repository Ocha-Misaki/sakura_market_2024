class CreateAddresses < ActiveRecord::Migration[7.1]
  def change
    create_table :addresses do |t|
      t.references :user, foreign_key: true, null: false
      t.string :address_name, default: '', null: false
      t.text :address, default: '', null: false
      t.timestamps
    end
  end
end
