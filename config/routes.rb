Rails.application.routes.draw do
  resources :orders
  post '/orders/:id' => 'orders#update'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root 'home#index'
  get '/partials/_header' => 'partials#_header'
end
