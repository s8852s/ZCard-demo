class CartsController < ApplicationController
	def add_item
		# 加購物車
		product = Product.find(params[:id])

		# cart = Cart.from_hash(session[:cart9527])
		current_cart.add_item(product.id)
		session[:cart9527] = current_cart.serialize
		# redirect_to pricing_path, notice: "已經加入購物車"
		render json: { status: 'ok', 
									count: current_cart.items.count, 
									total_price: current_cart.total_price } 
									# pricing要加remote: true
	end

	def show
		
	end

	def destroy
		session[:cart9527] = nil
		redirect_to pricing_path, notice: '購物車已清空'
	end

	def checkout
		@order = Order.new
		@token = gateway.client_token.generate
	end

	private
	def gateway
    Braintree::Gateway.new(
      :environment => :sandbox,
      :merchant_id => 'xdw6t47jkdhs2fhg',
      :public_key => 'gcm4wg8ygxmv2gyt',
      :private_key => '51848bd033d88fd80a071363fb6c176d',
    )
  end
end
