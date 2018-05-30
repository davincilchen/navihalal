Rails.application.routes.draw do
  devise_for :users
  root 'restaurants#index'
  resources :restaurants do
    member do
      post :collect
      post :uncollect
    end
  end
  get :search, controller: :restaurants
  resources :users do
    member do
      get :collection
    end
  end
  resources :tags, only: [:show]
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  namespace :admin do
    root 'users#index'
    resources :restaurants
    resources :users
  end
end
