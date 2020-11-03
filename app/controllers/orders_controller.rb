class OrdersController < ApplicationController

	before_action :authenticate_user!

	def create
		@order = Order.new(order_params)
		@order.user = current_user
		@items = CartItem.where(id: params[:items])
		@order.total = current_cart.total_price(@items)

		if @order.save
			@items.each do |item|
				product_list = ProductList.new
				product_list.order = @order
				product_list.product_name = item.product.title
				product_list.product_price = item.product.price
				product_list.quantity = item.quantity
				product_list.save
			end
			OrderMailer.notify_order_placed(@order).deliver!
			redirect_to order_path(@order.token)
		else
			render 'carts/checkout'
		end
	end

	def show
		@order = Order.find_by_token(params[:id])
		@product_lists = @order.product_lists
	end

	def pay_with_alipay
		@order = Order.find_by_token(params[:id])
		@order.set_payment_with!("alipay")
		@order.make_payment!
		back_url
		flash[:notice] = "支付宝支付成功"
	end

	def pay_with_wechat
		@order = Order.find_by_token(params[:id])
		@order.set_payment_with!("wechat")
		@order.make_payment!
		back_url
		flash[:notice] = "微信支付成功"
	end

	private

	def order_params
		params.require(:order).permit(:name, :cellphone, :address)
	end
end
