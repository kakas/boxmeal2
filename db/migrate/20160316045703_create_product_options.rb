class CreateProductOptions < ActiveRecord::Migration
  def change
    create_table :product_options do |t|
      t.integer :product_id
      t.string :content
      t.integer :price, default: 0

      t.timestamps null: false
    end
  end
end
