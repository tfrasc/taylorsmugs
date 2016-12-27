Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  resources :orders, except: :index
  post 'orders/pay_online', to: 'orders#pay_online'
  get '/admin', to: 'orders#index'
  get '/login', to: 'orders#login'
  post '/admin_login', to: 'orders#admin_login'

  root 'home#index'
end
