class CreateAppends < ActiveRecord::Migration
  def change
    create_table :appends do |t|
      t.integer :order_item_id
      t.integer :product_option_id

      t.timestamps null: false
    end
  end
end
