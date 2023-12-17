module PromotionsHelper
  def handle_nested_attributes(promotion, params)
    params[:discounts_attributes]&.each do |discount_params|
      promotion.discounts.create(discount_params)
    end

    return unless params[:conditions_attributes]

    params[:conditions_attributes]&.each do |condition_params|
      promotion.conditions.create(condition_params)
    end
  end
end
