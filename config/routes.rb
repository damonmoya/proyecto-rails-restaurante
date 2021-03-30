Rails.application.routes.draw do
  resources :books
   get 'restaurant/index'
   root to: 'restaurant#index'
end
