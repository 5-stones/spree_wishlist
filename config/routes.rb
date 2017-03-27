Spree::Core::Engine.add_routes do
  resources :wishlists
  resources :wished_products, only: [:create, :update, :destroy]
  get '/wishlist' => 'wishlists#default', as: 'default_wishlist'

  namespace :api, defaults: { format: 'json' } do
    namespace :v1 do
      resources :wishlists do
        resources :wished_products, only: [:index]
      end
      resources :wished_products, only: [:new, :create, :update, :destroy]
      get 'wishlist' => 'wishlists#default', as: 'default_wishlist'
    end
  end

end
