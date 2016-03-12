class CreateProducts < ActiveRecord::Migration
  def change
    create_table :products do |t|
      t.integer :store_id
      t.string :title
      t.integer :price

      t.timestamps null: false
    end
  end
end
