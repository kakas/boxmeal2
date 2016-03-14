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

end
