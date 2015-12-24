class StoreController < ApplicationController
  def index
    @products = Product.order(:title)
    count = increment_count
    @message = "You've been here #{count} times" if session[:counter] > 5
  end
  
  private
  def increment_count
    session[:counter] ||= 0
    session[:counter] += 1
  end
end
