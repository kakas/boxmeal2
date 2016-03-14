class Store < ActiveRecord::Base

  has_many :products, dependent: :destroy
  has_many :groupons
  accepts_nested_attributes_for :products, reject_if: :all_blank, allow_destroy: true

end
