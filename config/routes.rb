Rails.application.routes.draw do
  resources :users
  resources :logins, only: [:new, :create, :destroy]
  resources :pictures do
    collection do
      post :confirm
    end
  end
end
