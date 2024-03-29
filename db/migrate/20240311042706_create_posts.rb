class CreatePosts < ActiveRecord::Migration[7.1]
  def change
    create_table :posts do |t|
      t.references :user, foreign_key: true, null: false
      t.string :title, default: '', null: false
      t.text :text, default: '', null: false
      t.timestamps
    end
  end
end
