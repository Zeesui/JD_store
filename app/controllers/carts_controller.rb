class CartsController < ApplicationController

	def cart_items_clean
		@cart_items = current_cart.cart_items
		@cart_items.destroy_all
		back_url
	end

	def checkout  
		@items = current_cart.cart_items.where(id: params[:item_ids])
		@order = Order.new
	end
end
