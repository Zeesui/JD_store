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
			redirect_to order_path(@order)
		else
			render 'carts/checkout'
		end
	end

	def show
		@order = Order.find(params[:id])
		@product_lists = @order.product_lists
	end

	private

	def order_params
		params.require(:order).permit(:name, :cellphone, :address)
	end
end
