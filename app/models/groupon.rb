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
    ((self.deadline - Time.zone.now)/60).round
  end

  def group_order_by_user_team
    orders.group_by { |order| order.user.team }
  end

  def total_price
    orders.inject(0) { |sum, order| sum + order.price }
  end
end
