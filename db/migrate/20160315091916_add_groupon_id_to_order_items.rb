class AddGrouponIdToOrderItems < ActiveRecord::Migration
  def change
    add_column :order_items, :groupon_id, :integer
  end
end
