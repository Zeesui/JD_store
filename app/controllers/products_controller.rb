class ProductsController < ApplicationController

	def index
		@product = Product.all.order("id DESC")
	end

	def show
		@product = Product.find(params[:id])
	end
end
