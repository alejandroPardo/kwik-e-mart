class ApplicationController < ActionController::Base
  skip_before_action :verify_authenticity_token

  def current_basket
    Basket.instance
  end

  def to_currency(number)
    number.round(2)
  end
end
