class CreateOrders < ActiveRecord::Migration
  def change
    create_table :orders do |t|
      t.integer :groupon_id
      t.integer :user_id
      t.integer :price
      t.boolean :is_paid
      t.string :token

      t.timestamps null: false
    end
  end
end
