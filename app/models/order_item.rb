class OrderItem < ActiveRecord::Base

  belongs_to :order
  belongs_to :product
  belongs_to :groupon
  has_many :appends
  has_many :opts, through: :appends, source: :product_option

  def total_price
    quantity * (product.price + opts.inject(0) { |sum, opt| sum + opt.price })
  end

  def binding_opts_string
    bundle = ""
    opts.each do |opt|
      bundle << " 加"
      bundle << opt.content
    end
    bundle
  end

end
