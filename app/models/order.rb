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

  def add_product_to_order(groupon, product)
    items << product
    order_items.last.update_columns(groupon_id: groupon)
    if product.store.is_drink?
      o = order_items.last
      o.update_columns(sugar: "半糖", ice: "少冰")
    end
    update_price
  end

  def pay!
    self.update_columns(is_paid: true)
  end

  def return_money!
    self.update_columns(is_paid: false)
  end


end
