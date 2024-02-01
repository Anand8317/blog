Rails.application.routes.draw do
  devise_for :users
  get 'likes/new'
  get 'likes/create'
  get 'new/create'
  get 'comments/new'
  get 'comments/create'
  root "users#index"
  resources :users, only: [:index, :show] do
    resources :posts, only: [:index, :show, :new, :create] do
      resources :comments, only: [:new, :create]
      resources :likes, only: [:new, :create]
    end
  end
  #get 'users/:user_id', to: 'users#show'
  #get 'users/:user_id/posts', to: 'posts#index'
  #get 'users/:user_id/posts/:post_id', to: 'posts#show'
end
