Rails.application.routes.draw do
  devise_for :users
  root to: 'articles#index'
  resources :articles do
    resources :comments, only: [:create, :destroy]
    resources :favorites, only: [:create, :destroy]
    resources :good_evaluations, only: [:create, :destroy]
    resources :bad_evaluations, only: [:create, :destroy]
    collection do
      get 'search'
    end
    member do
      get 'category'
    end
  end

  resources :users, only: [:show, :edit, :update]
  resources :relationships, only: [:create, :destroy]

end