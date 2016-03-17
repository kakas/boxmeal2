class Groupon < ActiveRecord::Base

  has_many :groupon_hosts, dependent: :destroy
  has_many :hosts, through: :groupon_hosts, source: :user
  belongs_to :store
  has_many :orders, dependent: :destroy
  has_many :order_items

  before_create :generate_token

  def generate_token
    self.token = SecureRandom.uuid
  end

  def times_up?
    Time.zone.now > self.deadline
  end

  def countdown
    time_count = self.deadline - Time.zone.now

    case time_count
    when 1..60
    "#{(time_count).round} 秒"
    when 61..3600
    "#{((time_count)/60).round} 分鐘"
    when 3601..86400
    "#{((time_count)/3600).round} 小時"
    else
    "#{((time_count)/86400).round} 天"
    end

  end

  def group_order_by_user_team
    orders.includes(:user, :order_items).group_by { |order| order.user.team }
  end

  def total_price
    orders.inject(0) { |sum, order| sum + order.price }
  end

  def group_order_items_by_title
    group_order_items = order_items.includes(:product).group_by { |order_item| order_item.product.title + " " + order_item.sugar + " " + order_item.ice }

    # calculate the order_items total price, and put in each other
    group_order_items.each do |product_title, order_item|
      group_order_items[product_title] = order_item.inject(0) { |sum, order_item| sum + order_item.quantity }
    end

  end
end
