class OrderItem < ActiveRecord::Base

  belongs_to :order
  belongs_to :product
  belongs_to :groupon
  has_many :appends
  has_many :product_options, through: :appends

end
