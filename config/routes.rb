Rails.application.routes.draw do
  root "Users#index"
  get 'users/user_id', to: 'Users#show'
  get 'users/user_id/posts', to: 'Posts#index'
  get 'users/user_id/posts/post_id', to: 'Posts#show'
  
end
