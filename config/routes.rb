BreadExpress::Application.routes.draw do

  # Routes for main resources
  resources :addresses
  resources :customers
  resources :orders
  resources :items
  resources :users
  resources :sessions

  # Authentication routes

resources :items do
  collection do
    post :addcart
    put :savecart
  end
end

  # Semi-static page routes
  get 'home' => 'home#home', as: :home
  get 'cart' => 'home#cart', as: :cart

  get 'about' => 'home#about', as: :about
  get 'contact' => 'home#contact', as: :contact
  get 'privacy' => 'home#privacy', as: :privacy
  get 'search' => 'home#search', as: :search
  get 'cylon' => 'errors#cylon', as: :cylon
  get 'user/edit' => 'users#edit', :as => :edit_current_user
  get 'signup' => 'users#new', :as => :signup

  get 'items/index' => 'items#add_to_cart', :as => :add_to_cart
  get 'items/index' => 'items#get_list_of_items_in_cart', :as => :get_list_of_items_in_cart

  get 'login' => 'sessions#new', :as => :login
  get 'logout' => 'sessions#destroy', :as => :logout
  # Set the root url
  root :to => 'home#home'  
  
  # Named routes



  
  # Last route in routes.rb that essentially handles routing errors
  get '*a', to: 'errors#routing'
end
