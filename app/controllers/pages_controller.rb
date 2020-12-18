class PagesController < ApplicationController
  def pricing
    @products = Product.order(price: :desc)
  end
    
end
