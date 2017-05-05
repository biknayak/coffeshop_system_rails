Rails.application.routes.draw do
  devise_for :users
  resources :categories
  resources :rooms
  resources :orders
  resources :products
  resources :users
  get '/products/search/:product_name', to: 'products#search'
  get '/adminHome' => 'admin_home#index'
  get '/order/products/:id' => 'orders#orderProducts'
  resources :checks
  resources :persons ,:controller => 'users'
  get '/user/:id/checks/:star/:end' => 'checks#user_checks'
  root to: redirect("/orders")



  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
