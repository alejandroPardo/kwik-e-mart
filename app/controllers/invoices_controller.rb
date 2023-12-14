class InvoicesController < ApplicationController

  # GET /invoices/1
  def show
    @invoice = Invoice.find(params[:id])
    if @invoice.present?
      render json: @invoice
    else
      head :no_content, status: :not_found
    end
  end
end
