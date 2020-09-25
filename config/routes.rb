Rails.application.routes.draw do
  resources :users
  resources :logins, only: [:new, :create, :destroy]
end
