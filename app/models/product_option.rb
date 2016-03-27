class ProductOption < ActiveRecord::Base

  belongs_to :store
  has_many :appends
  has_many :order_items, through: :appends

end
