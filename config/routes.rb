Rails.application.routes.draw do
  devise_for :users
  root 'restaurants#index'
  resources :restaurants
  get :search, controller: :restaurants
  resources :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  namespace :admin do
    root 'users#index'
    resources :restaurants
    resources :users
  end
end
