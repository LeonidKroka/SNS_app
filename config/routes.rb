Rails.application.routes.draw do
  get 'users/new'

  get 'account_activation', to: 'users#account_activation'
  get 'password_reset', to: 'users#password_reset'
end
