Rails.application.routes.draw do
  devise_for :users
  resources :categories
  resources :rooms
  resources :orders
  resources :products
  resources :users
  get '/products/search/:product_name', to: 'products#search'
  get '/adminHome' => 'admin_home#index'
  get '/adminHome/change/:userID/:orderID' => 'admin_home#change'
  get '/order/products/:id' => 'orders#orderProducts'
  get '/products/:state/:productID' => 'products#changeProductState'
  resources :checks
  resources :persons ,:controller => 'users'
  get '/user/:id/checks/:start/:ends' => 'checks#user_checks'
  get '/check/:id/products' =>'checks#check_product'
  root to: redirect("/orders")



  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
