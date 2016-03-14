class CreateGrouponHosts < ActiveRecord::Migration
  def change
    create_table :groupon_hosts do |t|
      t.integer :user_id
      t.integer :groupon_id

      t.timestamps null: false
    end
  end
end
