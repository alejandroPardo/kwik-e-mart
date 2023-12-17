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

  def calculate_price
    price = 0
    discounts = 0

    products = current_basket.items.map do |product_id, quantity|
      product = Product.select(:id, :code, :name, :price).find(product_id)
      total_price = product.price * quantity
      total_discount = product.promotions.each_with_object({}) do |promotion, acc|
        next unless conditions_apply?(promotion, quantity)

        acc[promotion.name] = apply_discounts(promotion, quantity)
      end

      price += total_price
      discounts += total_discount.values.sum unless total_discount.empty?

      { product:, quantity:, total_price: to_currency(total_price), total_discount: }
    end

    { price: price.to_f, discounts: to_currency(discounts),
      final_price: to_currency(price.to_f - discounts), products: }
  end

  private

  def conditions_apply?(promotion, quantity)
    promotion.conditions&.each do |condition|
      case condition.condition_type
      when 'min_quantity'
        return false unless quantity >= condition.condition_value.to_i
      end
    end
    true
  end

  def apply_discounts(promotion, quantity)
    promotion.discounts.sum do |discount|
      case discount.discount_type
      when 'free_product'
        how_many = promotion.conditions.find do |condition|
                     condition.condition_type == 'min_quantity'
                   end&.condition_value.to_i || 1
        to_currency(promotion.product.price.to_f * (quantity / how_many))
      when 'fixed_price'
        to_currency((promotion.product.price.to_f * quantity) - (discount.discount_value.to_f * quantity))
      when 'percentage'
        to_currency(promotion.product.price.to_f * quantity * (discount.discount_value.to_f / 100.0))
      end
    end
  end
end
