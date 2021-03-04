Rails.application.routes.draw do

  devise_for :users
  
  resources :users, only: [:show, :index, :edit, :update] do
    member do
        get :following, :followers
      end
    end
    # resource :relationships, only: [:create, :destroy]
  
  post 'follow/:id' => 'relationships#follow', as: 'follow' 
  post 'unfollow/:id' => 'relationships#unfollow', as: 'unfollow' 
  
  # get 'users/:user_id/follows' => 'relationships#following', as: 'followings'
  # get 'users/:user_id/followers' => 'relationships#follower', as: 'followers'
  
  resources :books do
    resource :favorites, only: [:create, :destroy]
    resources :book_comments, only: [:create, :destroy]
  end

  root 'homes#top'
  get 'home/about' => 'homes#about'
  get "search" => "search#search"

end