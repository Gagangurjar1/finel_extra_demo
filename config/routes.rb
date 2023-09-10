Rails.application.routes.draw do
  post 'user_login', to: 'users#user_login'
  resources :users
  resources :products
  resources :purchases
  get 'search_product_by_name', to: 'products#search_product_by_name'
  get 'search_product_by_category', to: 'products#search_product_by_category'
end
