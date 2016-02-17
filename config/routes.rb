Rails.application.routes.draw do
  devise_for :admins
  mount RailsAdmin::Engine => '/admins', as: 'rails_admin'
  devise_for :customers, :controllers => { :omniauth_callbacks => "customers/omniauth_callbacks" }
  devise_scope :customers do
    get   'customer/settings',                :to => 'settings#edit'
    patch 'customer/update_personal_data',    :to => 'settings#update_personal_data'
    patch 'customer/update_password',         :to => 'settings#update_password'
    put   'customer/update_billing_address',  :to => 'settings#update_billing_address'
    put   'customer/update_shipping_address', :to => 'settings#update_shipping_address'
  end
  resource :customer, only: [:edit] do
    patch 'update_personal_data'
    patch 'update_password'
    put   'update_billing_address'
    put   'update_shipping_address'
  end
  root 'books#bestsellers'
  resources :books, only: [:index, :show] do
    resources :ratings, only: [:new, :create]
  end
  resources :categories, only: [:index, :show]
  resources :authors, only: [:show]
  resources :order_items
  resources :carts, only: [:index] do
    collection do
      post    'add_item'
      delete  'remove_item'
      delete  'clear'
    end
  end
  resources :orders, only: [:index, :show] do
    collection do
      get   'address'
      patch 'update_billing_address'
      post  'create_shipping_address'
      get   'delivery'
      post  'create_delivery'
      get   'payment'
      post  'create_payment'
      get   'overview'
      post  'confirm'
    end
  end
  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  # root 'welcome#index'

  # Example of regular route:
  #   get 'products/:id' => 'catalog#view'

  # Example of named route that can be invoked with purchase_url(id: product.id)
  #   get 'products/:id/purchase' => 'catalog#purchase', as: :purchase

  # Example resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Example resource route with options:
  #   resources :products do
  #     member do
  #       get 'short'
  #       post 'toggle'
  #     end
  #
  #     collection do
  #       get 'sold'
  #     end
  #   end

  # Example resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Example resource route with more complex sub-resources:
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', on: :collection
  #     end
  #   end

  # Example resource route with concerns:
  #   concern :toggleable do
  #     post 'toggle'
  #   end
  #   resources :posts, concerns: :toggleable
  #   resources :photos, concerns: :toggleable

  # Example resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end
end
