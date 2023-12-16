class ApplicationController < ActionController::Base
  skip_before_action :verify_authenticity_token

  def current_basket
    session[:basket] ||= {}
    @current_basket ||= Basket.new(session[:basket])
  end
end
