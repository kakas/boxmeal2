module OrdersHelper

  def order_editable?(order)
    !order.is_paid? && !order.groupon.times_up?
  end

  def render_delete_order_path(order, order_item)
    link_to order_order_item_path(@order, order_item), method: :delete, data: { confirm: "確定刪除#{order_item.product.title}"  } do
      content_tag :i, " ", class: "fa fa-trash fa-2x"
    end
  end

end
