class PromotionsController < ApplicationController
  include PromotionsHelper

  def index
    @promotions = Promotion.includes(:discounts, :conditions).all
    render json: @promotions, include: %i[discounts conditions]
  end

  def show
    @promotion = Promotion.includes(:discounts, :conditions).find(params[:id])
    render json: @promotion, include: %i[discounts conditions]
  end

  def create
    @promotion = Promotion.new(promotion_params.except(:discounts_attributes, :conditions_attributes))
    if @promotion.save
      handle_nested_attributes(@promotion, promotion_params)
      render json: @promotion, status: :created
    else
      render json: @promotion.errors, status: :unprocessable_entity
    end
  end

  def update
    @promotion = Promotion.find(params[:id])
    if @promotion.update(promotion_params)
      render json: @promotion, status: :ok
    else
      render json: @promotion.errors, status: :unprocessable_entity
    end
  end

  def destroy
    @promotion = Promotion.find(params[:id])
    @promotion.destroy
    head :no_content
  end

  private

  def promotion_params
    params.require(:promotion).permit(
      :name, :description, :start_date, :end_date, :product_id,
      discounts_attributes: %i[id discount_type discount_value _destroy],
      conditions_attributes: %i[id condition_type condition_value _destroy]
    )
  end
end
