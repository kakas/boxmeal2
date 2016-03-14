class Groupon < ActiveRecord::Base

  has_many :groupon_hosts
  has_many :hosts, through: :groupon_hosts, source: :user
  has_one :store

end
