class StoreController < ApplicationController
  include CurrentCart
  skip_before_action :authorize
  before_action :set_cart
  
  def index
    if params[:set_locale]
      redirect_to store_url(locale: params[:set_locale])
    else
      @products = Product.order(:title)
    end
    count = increment_count
    @message = "You've been here #{count} times" if session[:counter] > 5
  end
  
  private
  def increment_count
    session[:counter] ||= 0
    session[:counter] += 1
  end
end
