class ProductsController < ApplicationController

	before_action :validate_search_key, only: [:search]

	def index
		@products = Product.all.order("id DESC")
	end

	def show
		@product = Product.find(params[:id])
	end

	def operations
		@product = Product.find(params[:id])
		@quantity = params[:quantity].to_i

 		case params[:option]
		when "add_to_cart"
			if !current_cart.products.include?(@product)
				current_cart.add_product_to_cart(@product, @quantity)
				flash[:notice] = "加入购物车"
			else
				flash[:notice] = "#{@product.title}商品已经加入购物车"
			end
			back_url
		 # when "order_now"
		 #
     #   redirect_to checkout_cart_path
		  end
	end

	def add_to_cart
		@product = Product.find(params[:id])
		@quantity = params[:quantity].to_i
		if !current_cart.products.include?(@product)
			current_cart.add_product_to_cart(@product, @quantity)
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

	def search
		if @query_string.present?
			search_result = Product.ransack(@search_criteria).result(:distinct => true)
			@products = search_result.paginate(:page => params[:page], :per_page => 10)
		end
	end

	protected

	def validate_search_key
		@query_string = params[:q].gsub(/\\|\'|\/|\?/, "") if params[:q].present?
		@search_criteria = search_criteria(@query_string)
	end

	def search_criteria(query_string)
		{title_or_description_cont: query_string}
	end
end
