class Groupon < ActiveRecord::Base

  has_many :groupon_hosts
  has_many :hosts, through: :groupon_hosts, source: :user
  belongs_to :store

  before_create :generate_token

  def generate_token
    self.token = SecureRandom.uuid
  end


end
