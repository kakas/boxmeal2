class Store < ActiveRecord::Base

  has_many :products, dependent: :destroy
  has_many :groupons
  has_many :opts, class_name: ProductOption, dependent: :destroy

  accepts_nested_attributes_for :opts, reject_if: :all_blank, allow_destroy: true
  accepts_nested_attributes_for :products, reject_if: :all_blank, allow_destroy: true

end
