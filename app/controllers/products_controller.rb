class ProductsController < ApplicationController

	def index
		@products = Product.all.order("id DESC")
	end

	def show
		@product = Product.find(params[:id])
	end

	def add_to_cart
		@product = Product.find(params[:id])
		if !current_cart.products.include?(@product)
			current_cart.add_product_to_cart(@product)
			flash[:notice] = "加入购物车"
		else
			flash[:notice] = "#{@product.title}商品已经加入购物车"
		end
		
		back_url

	end
end
