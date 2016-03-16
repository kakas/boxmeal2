class Product < ActiveRecord::Base

  belongs_to :store
  has_many :opts, class_name: ProductOption, dependent: :destroy

end
