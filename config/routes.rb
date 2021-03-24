Rails.application.routes.draw do
   get 'restaurant/index'
   root to: 'restaurant#index'
end
