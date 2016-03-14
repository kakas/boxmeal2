class AddStoreIdToGroupon < ActiveRecord::Migration
  def change
    add_column :groupons, :store_id, :integer
  end
end
