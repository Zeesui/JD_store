class Admin::ProductsController < ApplicationController

	before_action :authenticate_user!
#	before_action :required_admin

	layout "admin"

	def index
		@products = Product.all
	end

	def new
		@product = Product.new
	end

	def create
		@product = Product.new(params_product)
		if @product.save
			redirect_to admin_products_path
		else
			render :new
		end
	end

	def edit
		@product = Product.find(params[:id])
	end

	def update
		@product = Product.find(params[:id])
		if @product.update(params_product)
			redirect_to admin_products_path
		else
			render :edit
		end
	end

	def show
		@product = Product.find(params[:id])
	end

	def destroy
		@product = Product.find(params[:id])
		@product.destroy
		redirect_to admin_products_path
	end

	def public
		@product = Product.find(params[:id])
		@product.public!
		back_url
	end

	def hide
		@product = Product.find(params[:id])
		@product.hide!
		back_url
	end

	private

	def params_product
		params.require(:product).permit(:title, :description, :price, :quantity, :image, :is_hidden)
	end


end
