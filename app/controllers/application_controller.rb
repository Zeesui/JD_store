class ApplicationController < ActionController::Base

	def required_admin
		if !current_user.admin?
			redirect_to "/"
			flash[:notice] = "你不是管理员"
		end
	end

	def is_login?
		if !current_user
			redirect_to new_user_session_path, notice: "需要登陆才能收藏"
		end
	end

	helper_method :current_cart

	def current_cart
		@current_cart ||= find_cart
	end

	def back_url
		redirect_back fallback_location: root_path
	end

	private

	def find_cart
		cart = Cart.find_by(id: session[:cart_id])
		if cart.blank?
			cart = Cart.create
		end
		session[:cart_id] = cart.id
		return cart
	end
end
