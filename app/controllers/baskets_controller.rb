class BasketsController < ApplicationController
  include BasketsHelper
  # GET /basket
  def index
    render json: calculate_price
  end

  # PATCH/PUT /basket/1
  def update
    @product = Product.find(params[:id])
    return head :not_found unless @product

    add_item_to_basket(@product.id.to_s)

    render json: current_basket, status: :created
  end

  # DELETE /basket/1
  def destroy
    @product = Product.find(params[:id])
    return head :not_found unless @product

    remove_item_from_basket(@product.id.to_s)
    head :no_content
  end

  # DELETE /basket
  def empty_basket
    remove_all_items_from_basket
    head :no_content
  end
end
