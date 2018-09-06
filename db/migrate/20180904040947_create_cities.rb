class CreateCities < ActiveRecord::Migration[5.2]
  def change
    create_table :spree_cities do |t|
      t.string :state_id
      t.string :name
    end
  end
end
