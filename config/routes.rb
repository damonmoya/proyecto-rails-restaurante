Rails.application.routes.draw do
  resources :books do
    get 'pay', on: :collection
    post 'checkout', on: :collection
  end
    get 'restaurant/index'
    root to: 'restaurant#index'
end
