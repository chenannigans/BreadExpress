BreadExpress::Application.routes.draw do

  # Routes for main resources
  resources :addresses
  resources :customers
  resources :orders
  resources :items
  resources :users
  resources :sessions


  get 'home' => 'home#home', as: :home
  get 'cart' => 'home#cart', as: :cart
  get 'place_order' => 'orders#new', :as => :place_order
  get 'about' => 'home#about', as: :about
  get 'contact' => 'home#contact', as: :contact
  get 'privacy' => 'home#privacy', as: :privacy
  get 'search' => 'home#search', as: :search
  get 'cylon' => 'errors#cylon', as: :cylon
  get 'user/edit' => 'users#edit', :as => :edit_current_user
  get 'signup' => 'customers#new', :as => :signup


  post 'ship_item/:id' => 'order_items#ship_item', :as => :ship_item

  post 'add_to_cart/:id' => 'items#add_to_cart', :as => :add_to_cart
  post 'remove_from_cart/:id' => 'items#remove_from_cart', :as => :remove_from_cart
  post 'calculate_cart_items_cost/:id' => 'items#calculate_cart_items_cost', :as => :calculate_cart_items_cost

  get 'login' => 'sessions#new', :as => :login
  get 'logout' => 'sessions#destroy', :as => :logout
  # Set the root url
  root :to => 'home#home'  
  
  # Named routes



  
  # Last route in routes.rb that essentially handles routing errors
  get '*a', to: 'errors#routing'
end
