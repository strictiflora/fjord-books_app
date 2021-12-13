Rails.application.routes.draw do
  get 'users/index'
  get 'users/show'
  root to: 'books#index'
  devise_for :users
  resources :users, :only => [:index, :show]
  resources :books
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
