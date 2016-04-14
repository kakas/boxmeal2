class Append < ActiveRecord::Base

  belongs_to :order_item
  belongs_to :product_option

end
