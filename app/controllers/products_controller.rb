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

	def collected
		@product = Product.find(params[:id])
		if current_user
			if current_user.is_member_of(@product)
				flash[:notice] = "#{@product.title} 已经收藏"
			else
				current_user.collected_product!(@product)
				flash[:notice] = "收藏成功"
			end
		else
			flash[:notice] = "需要登录才能收藏"
		end
		back_url
	end

	def uncollected
		@product = Product.find(params[:id])
		current_user.uncollected_product!(@product)
		flash[:notice] = "取消收藏"
		back_url
	end
end
