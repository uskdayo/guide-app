Rails.application.routes.draw do
  devise_for :users
  root to: 'posts#index'
  resources :posts, only: [:show] do
    resources :comments, only: :create
    namespace :admin do
      resources :posts, only: [:index, :new, :create, :show, :edit, :destroy]
    end
  end
  resources :users, only: [:show, :edit, :update, :destroy]
end
