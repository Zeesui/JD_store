Rails.application.routes.draw do

  devise_for :users
	root 'products#index'

	namespace :admin do
		resources :products
    resources :orders do
      member do
        post :cancel
        post :ship
        post :shipped
        post :return
      end
    end
	end

	resources :products do
		member do
			post :add_to_cart
		end
	end

	resources :carts do
		collection do
			delete :cart_items_clean
			get :checkout
		end
	end


	resources :cart_items do
		member do
			post :increase
			post :decrease
		end
	end

	resources :orders do
		member do
			post :pay_with_alipay
			post :pay_with_wechat
		end
	end

	namespace :account do
		resources :orders
	end

end
