class CartItemsController < ApplicationController

	def destroy
		@cart_item = current_cart.cart_items.find_by(product_id: params[:id])
		@cart_item.destroy
	#	back_url
	end

	

	def increase
		@cart_item = current_cart.cart_items.find_by(product_id: params[:id])
		@quantity = @cart_item.quantity
		if @quantity < @cart_item.product.quantity
			@cart_item.change_quantity(1)
		end
	#	back_url
	end

	def decrease
		@cart_item = current_cart.cart_items.find_by(product_id: params[:id])
		@quantity = @cart_item.quantity
		if @quantity > 1
			@cart_item.change_quantity(-1)
		end
		render 'increase'
	#	back_url
	end

	def update
		@cart_item = current_cart.cart_items.find_by(product_id: params[:id])
		@cart_item.update(cart_item_params)
		back_url
	end

	private

	def cart_item_params
		params.require(:cart_item).permit(:quantity)
	end

	
end
