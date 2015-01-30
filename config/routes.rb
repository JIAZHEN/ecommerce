Rails.application.routes.draw do

  resources :payments

  resource :cart, only: [:show] do
    put "add/:product_id", to: "carts#add", as: :add_to
    put "remove/:product_id", to: "carts#remove", as: :remove_from
  end

  root  :to       => "welcome#index"
  get   "about"   => "welcome#about"
  get   "contact" => "welcome#contact"

  resources :sessions, only: [:new, :create, :destroy]
  resources :users, only: [:new, :create, :show]
  get     "login"     => "sessions#new"
  post    "login"     => "sessions#create"
  delete  "logout"    => "sessions#destroy"
  get     "register"  => "users#new"
  get "account" => "users#show"

  resources :products,    only: [:show, :index]

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
