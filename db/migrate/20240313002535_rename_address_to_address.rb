class RenameAddressToAddress < ActiveRecord::Migration[7.1]
  def change
    rename_column :addresses, :address, :location
  end
end
