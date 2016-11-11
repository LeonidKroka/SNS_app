Rails.application.routes.draw do
  root 'sessions#new'

  get 'account_activation', to: 'users#account_activation'
  get 'password_reset', to: 'users#password_reset'
  post 'search', to:'users#search'
  get    '/login',   to: 'sessions#new'
  post   '/login',   to: 'sessions#create'
  delete '/logout',  to: 'sessions#destroy'
  get '/friends', to: 'users#friends'
  resources :users do
    resources :posts
    resources :images
    resources :comments
    resources :messages
  end
end
