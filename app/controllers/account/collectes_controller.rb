class Account::CollectesController < ApplicationController

  before_action :authenticate_user!
  layout "current_user"

  def index
    @products = current_user.favorited_products
  end
end
