Rails.application.routes.draw do
  resources :books do
    get 'pay', on: :member
  end
    get 'restaurant/index'
    root to: 'restaurant#index'
end
