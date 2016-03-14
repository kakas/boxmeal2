class ChangeOrderIsPaidDefaultFalse < ActiveRecord::Migration
  def change
    change_column_default :orders, :is_paid, false
  end
end
