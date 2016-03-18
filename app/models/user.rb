class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise  :registerable, :rememberable, :trackable, :omniauthable, :omniauth_providers => [:facebook]

  has_many :groupon_hosts
  has_many :groupons, through: :groupon_hosts
  has_many :orders, dependent: :destroy

  def to_admin!
    self.update_columns(is_admin: true)
  end

  def to_normal!
    self.update_columns(is_admin: false)
  end

  def self.from_omniauth(auth)
    where(provider: auth.provider, uid: auth.uid).first_or_create do |user|
      user.email = auth.info.email if auth.info.email.present?
      user.encrypted_password = Devise.friendly_token[0,20]
      user.name = auth.info.name if user.name.blank?
      # user.image = auth.info.image # assuming the user model has an image
    end
  end

end
