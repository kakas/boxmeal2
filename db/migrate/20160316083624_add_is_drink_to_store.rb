class AddIsDrinkToStore < ActiveRecord::Migration
  def change
    add_column :stores, :is_drink, :boolean
  end
end
