Rails.application.routes.draw do
  root to: 'home#index'
  devise_for :users

  resources :users, only: [:index, :show] do
    resource :profile, only: [:show, :edit, :update]
  end

  resources :posts do
    resources :comments, only: [:create, :destroy]
    resource :like, only: [:create, :destroy]
  end

  # 新規投稿ページへのルート
  get 'posts/new/:type', to: 'posts#new', as: 'new_post_with_type'

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
