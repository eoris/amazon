Rails.application.routes.draw do
  devise_for :admins
  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'
  devise_for :customers, :controllers => { :omniauth_callbacks => "customers/omniauth_callbacks" }
  resource :customer, only: [:edit, :update] do
    patch 'update_addresses'
  end

  root 'books#bestsellers'
  resources :books, only: [:index, :show] do
    resources :ratings, only: [:new, :create]
  end
  resources :categories, only: [:index, :show]
  resources :authors, only: [:show]

  resource :cart, only: [:show] do
    post    'add_item'
    delete  'remove_item'
    post    'checkout'
    delete  'clear'
  end

  resources :orders, only: [:index, :show] do
    resource :checkout, only: [:show] do
      get   'addresses'
      patch 'update_addresses'
      get   'delivery'
      patch 'update_delivery'
      get   'payment'
      patch 'update_payment'
      get   'confirm'
      post  'place'
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
