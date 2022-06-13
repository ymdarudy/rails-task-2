Rails.application.routes.draw do
  root "pictures#index"
  resources :users, only: [:new, :create, :show]
  resources :pictures
  resources :sessions, only: [:new, :create, :destroy]
end
