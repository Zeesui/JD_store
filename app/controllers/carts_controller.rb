class CartsController < ApplicationController

	def cart_items_clean
		@cart_items = current_cart.cart_items
		@cart_items.destroy_all
		back_url
	end

	def operations
		if params[:delete_items].present?
			delete_items
		elsif params[:checkout].present?
			do_checkout
		end
	end

	def checkout
		@items = []
		if params[:item_ids].present?		
	    params[:item_ids].each do |item_id|
	      @items << CartItem.find(item_id)
	    end
		else

		end
		@order = Order.new
	end



	private

	def delete_items
		if params[:item_ids].present?
			params[:item_ids].each do |item_id|
			current_cart.cart_items.find(item_id).destroy
				end
		else
			flash[:notice] = "至少选中一个商品"
	end
		back_url
	end

	def do_checkout
	    unless params[:item_ids].present?
	      flash[:warning] = "请至少选中一个商品"
	      redirect_to carts_path
	    else
	      redirect_to checkout_cart_path(item_ids: params[:item_ids])
	    end
	  end

end
