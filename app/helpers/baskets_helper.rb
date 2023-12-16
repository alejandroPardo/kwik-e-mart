module BasketsHelper
  def add_item_to_basket(product_id)
    current_basket.add_item(product_id)
    update_basket
  end

  def remove_item_from_basket(product_id)
    current_basket.remove_item(product_id)
    update_basket
  end

  def remove_all_items_from_basket
    current_basket.empty
    update_basket
  end

  def update_basket
    session[:basket] = current_basket.items
  end
end
