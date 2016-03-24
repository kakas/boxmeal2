class AddIceAndSugarToOrderItems < ActiveRecord::Migration
  def change
    add_column :order_items, :ice, :string, default: ""
    add_column :order_items, :sugar, :string, default: ""
  end
end
