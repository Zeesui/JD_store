class ProductsController < ApplicationController

	def index
		@products = Product.all.order("id DESC")
	end

	def show
		@product = Product.find(params[:id])
	end

	def add_to_cart
		@product = Product.find(params[:id])
		redirect_back fallback_location: root_path
		flash[:notice] = "测试购物车"
	end
end
