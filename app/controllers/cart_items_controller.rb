class CartItemsController < ApplicationController

	before_action :find_cart_item, only: [:destroy, :increase, :decrease, :update]

	#删除购物车商品
	def destroy

		@cart_item.destroy
	#	back_url
	end


	#增加购物车商品数量
	def increase

		@quantity = @cart_item.quantity
		if @quantity < @cart_item.product.quantity
			@cart_item.change_quantity(1)
		end
	#	back_url
	end

	#减少购物车商品数量
	def decrease

		@quantity = @cart_item.quantity
		if @quantity > 1
			@cart_item.change_quantity(-1)
		end
		render 'increase'
	#	back_url
	end

	def update

		@cart_item.update(cart_item_params)
		back_url
	end

	private

	def cart_item_params
		params.require(:cart_item).permit(:quantity)
	end

  def find_cart_item
		@cart = current_cart
		@cart_item = @cart.cart_items.find_by(product_id: params[:id])
  end


end
