class CartItemsController < ApplicationController

	def destroy
		@cart_item = current_cart.cart_items.find_by(product_id: params[:id])
		@cart_item.destroy
		back_url
	end

	def cart_items_clean
		@cart_items = current_cart.cart_items
		@cart_items.destroy_all
		back_url
	end

	

	
end
