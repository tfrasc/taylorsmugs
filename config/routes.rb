Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  resources :orders
  post 'orders/pay_online', to: 'orders#pay_online'

  root 'home#index'
end
