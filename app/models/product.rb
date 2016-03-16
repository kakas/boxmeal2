class Product < ActiveRecord::Base

  belongs_to :store
  has_many :opts, class_name: ProductOption, dependent: :destroy

  accepts_nested_attributes_for :opts, reject_if: :all_blank, allow_destroy: true

end
