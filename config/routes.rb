Rails.application.routes.draw do
  devise_for :admins
  resources :books do
    get 'pay', on: :collection
    post 'checkout', on: :collection
    get 'mybooks', on: :collection
  end
    get 'restaurant/index'
    post 'restaurant/index' => 'restaurant#create'
    post 'restaurant/mybooks' => 'restaurant#getBooks'
    root to: 'restaurant#index'
end
