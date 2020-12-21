class OrdersController < ApplicationController
  def create
    # 建立訂單
    order = current_user.orders.new(order_params)
    current_cart.items.each do |item|
      order.order_items << OrderItem.new(product: item.product, 
                                        quantity: item.quantity)
    end
    # linepay---------------------------------------------------
    # if order.save
    #   resp = Faraday.post("#{ENV['line_pay_endpoint']}/v2/payments/request") do |req|
    #   req.headers['Content-Type'] = 'application/json'
    #   req.headers['X-LINE-ChannelId'] = ENV['line_pay_channel_id']
    #   req.headers['X-LINE-ChannelSecret'] = ENV['line_pay_channel_secret']
    #   req.body = {
    #     productName: "Zcard大平台",
    #     amount: current_cart.total_price.to_i,
    #     currency: "TWD",
    #     confirmUrl: "http://localhost:3000/orders/confirm",
    #     orderId: @order.num
    #   }.to_json
    #   end

    #   result = JSON.parse(resp.body)

    #   if result['returnCode'] == "0000"
    #     payment_url = result['info']['paymentUrl']['web']
    #     redirect_to payment_url
    #   else
    #     flash[:notice] = '付款發生錯誤' 
    #     render 'carts/checkout'
      
    #   end


    #   redirect_to root_path, notice: "訂單已建立"
    # else
    # end
    # linepay---------------------------------------------------
    order.save
    # 付錢
    nonce = params[:payment_method_nonce]
    result = gateway.transaction.sale(
      :amount => current_cart.total_price,
      :payment_method_nonce => nonce
    )

    if result.success?
      # 清空購物車
      session[:cart9527] = nil
      # 訂單改狀態
      order.pay!

      redirect_to root_path, notice: '感謝大爺'
    else
      redirect_to root_path, notice: '發生錯誤'
    end
    # render json: result

  end
  private 
  def gateway
    Braintree::Gateway.new(
      :environment => :sandbox,
      :merchant_id => ENV['braintree_merchant_id'],
      :public_key => ENV['braintree_public_key'],
      :private_key => ENV['braintree_private_key']
    )
  end

  def order_params
    params.require(:order).permit(:username, :tel, :address)
    # 不應該開放:user_id，而是用current_user
  end

end
