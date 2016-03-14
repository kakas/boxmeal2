class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_many :groupon_hosts
  has_many :groupons, through: :groupon_hosts

  validates :email, presence: true
  validates :name, presence: true
  validates :team, presence: true
end
