class Order < ActiveRecord::Base

  belongs_to :user
  belongs_to :groupon
  has_many :order_items
  has_many :item, through: :order_items, source: :product

end
