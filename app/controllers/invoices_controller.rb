class InvoicesController < ApplicationController
  include BasketsHelper

  # GET /invoices/1
  def show
    @invoice = Invoice.includes(:items).find(params[:id])
    if @invoice.present?
      render json: { invoice: @invoice, items: @invoice.items }
    else
      head :no_content, status: :not_found
    end
  end

  # POST /invoices
  def create
    basket = calculate_price
    items = basket[:products].map do |product_info|
      product = product_info[:product]
      quantity = product_info[:quantity]
      total_price = product_info[:total_price]
      total_discount = product_info[:total_discount]

      InvoiceItem.new(product_id: product.id, quantity:,
                      unit_price: to_currency(total_price.to_f - total_discount.values.sum))
    end

    @invoice = Invoice.new(amount: basket[:final_price], status: 1, items:)

    if @invoice.save
      remove_all_items_from_basket
      render json: @invoice, status: :created, location: @invoice
    else
      render json: @invoice.errors, status: :unprocessable_entity
    end
  end
end
