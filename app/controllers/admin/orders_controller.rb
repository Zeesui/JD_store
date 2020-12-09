class Admin::OrdersController < ApplicationController

  before_action :authenticate_user!
#  before_action :required_admin

  layout "admin"

  def index
    @orders = Order.order("id DESC")
  end

  def show
    @order = Order.find(params[:id])
    @product_lists = @order.product_lists
  end

  #出货
  def ship
    @order = Order.find(params[:id])
    @order.ship!
    back_url
  end

  #允许退货
  def return
    @order = Order.find(params[:id])
    @order.return_good!
    back_url
  end
end
