Rails.application.routes.draw do

  devise_for :users
	root 'products#index'

	namespace :admin do
		resources :products
	end

	resources :products do
		member do
			post :add_to_cart
		end
	end

	resources :carts do
		collection do
			delete :cart_items_clean
			post :checkout
		end
	end


	resources :cart_items do
		
		member do
			post :increase
			post :decrease
		end
	end
end
