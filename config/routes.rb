Rails.application.routes.draw do

  devise_for :users
	root 'products#index'

	namespace :admin do
		resources :products do
      collection do
        get 'create', as: :create
      end
      member do
        post :public
        post :hide
      end
    end
    resources :orders do
      member do

        post :ship

        post :return
      end
    end
	end

	resources :products do
		member do
			post :add_to_cart
      post :collected
      post :uncollected
      post :operations
		end
    collection do
      get :search
    end
	end

	resources :carts do
		collection do
			delete :cart_items_clean

		end
    member do
      post :operations
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
		resources :orders do
      member do
        post :apply_to_cancell
        post :cancell
        post :order_commit
      end
    end
    resources :collectes
	end

end
