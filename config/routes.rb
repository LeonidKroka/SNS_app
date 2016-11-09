Rails.application.routes.draw do
  root 'sessions#new'

  get 'account_activation', to: 'users#account_activation'
  get 'password_reset', to: 'users#password_reset'
  get    '/login',   to: 'sessions#new'
  post   '/login',   to: 'sessions#create'
  delete '/logout',  to: 'sessions#destroy'
  resources :users
end
