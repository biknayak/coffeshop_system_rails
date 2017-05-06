Rails.application.routes.draw do
  devise_for :users
  resources :categories
  resources :rooms
  resources :orders
  resources :products
  resources :checks
  resources :persons ,:controller => 'users'
  get '/user/:id/checks/:start/:ends' => 'checks#user_checks'
  get '/check/:id/products' =>'checks#check_product'
  root to: redirect("/orders")



  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
