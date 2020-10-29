class OrdersController < ApplicationController

	before_action :authenticate_user!

	def create
		@order = Order.new(order_params)
		@order.user = current_user
		@items = CartItem.where(id: params[:items])
		@order.total = current_cart.total_price(@items)

		if @order.save
			redirect_to order_path(@order)
		else
			render 'carts/checkout'
		end
	end

	private

	def order_params
		params.require(:order).permit(:name, :cellphone, :address)
	end
end
