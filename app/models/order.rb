class Order < ActiveRecord::Base

  belongs_to :user
  belongs_to :groupon
  has_many :order_items, dependent: :destroy
  has_many :items, through: :order_items, source: :product

  before_create :generate_token

  def generate_token
    self.token = SecureRandom.uuid
  end

  def calculate_price
    order_items.inject(0) { |sum, order_item| sum + order_item.product.price * order_item.quantity }
  end

  def update_price
    self.update_columns(price: calculate_price)
  end

  def add_product_to_order(product)
    items << product
    update_price
  end

end
