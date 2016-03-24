module GrouponsHelper

  def time_format(time)
    time.strftime("%m月%d日, %H時%M分")
  end

  def render_pay_money_button(groupon, order)
    if groupon.hosts.include?(current_user)
      if order.is_paid?
        link_to "退款", return_money_groupon_order_path(groupon.token, order.token), method: :post, class: "btn btn-warning btn-xs"
      else
        link_to "設定為已付款", pay_money_groupon_order_path(groupon.token, order.token), method: :post, class: "btn btn-info btn-xs"
      end
    else
      if order.is_paid?
        "已付款"
      else
        "未付款"
      end
    end

  end

end
