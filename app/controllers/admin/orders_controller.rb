class Admin::OrdersController < ApplicationController

  before_action :authenticate_user!
  before_action :required_admin

  def index
    @orders = Order.order("id DESC")
  end

  def show
    @order = Order.find(params[:id])
    @product_lists = @order.product_lists
  end

  def ship
    @order = Order.find(params[:id])
    @order.ship!
    back_url
  end

  def shipped
    @order = Order.find(params[:id])
    @order.deliver!
    back_url
  end

  def cancel
    @order = Order.find(params[:id])
    @order.cancel_order!
    back_url
  end

  def return
    @order = Order.find(params[:id])
    @order.return_good!
    back_url
  end
end
