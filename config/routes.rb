Rails.application.routes.draw do
  #devise_for :users
  devise_for :users, controllers: { omniauth_callbacks: "users/omniauth_callbacks" }
  root 'restaurants#index'
  resources :restaurants do
    collection do
      post :import
    end
    member do
      post :collect
      post :uncollect
    end
  end
  get :search, controller: :restaurants
  resources :users do
    member do
      get :collection
      get :followings
    end
  end
  
  resources :activities do
    collection  do
      patch :check
    end
  end


  resources :tags, only: [:show]
  resources :followships, only: [:create, :destroy]
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  
  namespace :admin do
    root 'users#index'
    resources :tags
    resources :restaurants
    resources :users
  end
end
