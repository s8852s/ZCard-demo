module CartsHelper
  def current_cart
    @_cart9527 ||= Cart.from_hash(session[:cart9527])
  end
end
