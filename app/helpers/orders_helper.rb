module OrdersHelper

  def order_editable?(order)
    !order.is_paid? && !order.groupon.times_up?
  end

end
