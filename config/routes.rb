Rails.application.routes.draw do
  root to: 'posts#top'
  devise_for :users, controllers: { omniauth_callbacks: 'users/omniauth_callbacks' }
  resources :users, only: [:show, :edit, :update, :index]
  resources :messages, only: [:show]

  mount ActionCable.server => '/cable'

  resources :posts, only: [:new, :index, :show, :edit, :update, :create, :destroy, :top] do
    resources :post_comments, only: [:create, :destroy]
    resource :favorites, only: [:create, :destroy]

 end
end
