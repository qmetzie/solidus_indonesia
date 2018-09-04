class ChangeCityDataTypeToInteger < ActiveRecord::Migration[5.2]
  def change
    remove_column :spree_addresses, :city, :string

    add_column :spree_addresses, :city_id, :integer
    add_column :spree_addresses, :city_name, :string

    add_index :spree_addresses, :city_id
  end
end
