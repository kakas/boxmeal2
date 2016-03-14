class CreateGroupons < ActiveRecord::Migration
  def change
    create_table :groupons do |t|
      t.datetime :deadline
      t.boolean :is_secret
      t.string :token

      t.timestamps null: false
    end
  end
end
