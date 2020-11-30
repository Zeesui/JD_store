class Account::OrdersController < ApplicationController

	before_action :authenticate_user!
	layout "current_user"

	def index
		@orders = current_user.orders.order('id DESC')
	end

	def show
		@order = Order.find_by_token(params[:id])
		@product_lists = @order.product_lists
	end

	#申请退货
	def apply_to_cancell
		@order = Order.find_by_token(params[:id])
		@order.apply_to_cancelled!
		flash[:notice] = "申请退货"
		back_url
	end

	#取消订单
	def cancell
		@order = Order.find_by_token(params[:id])
		@order.cancell_order!
		back_url
	end

	#确认收货
	def order_commit
		@order = Order.find_by_token(params[:id])
		@order.good_shipped!
		back_url
	end
end
