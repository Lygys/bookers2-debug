Rails.application.routes.draw do

  devise_for :users

  resources :users,only: [:show,:index,:edit,:update]
  resources :books do
    resource :favorites, only: [:create, :destroy]
    resources :commentsm only: [:create, :destroy]

  end

  root 'homes#top'
  get 'home/about' => 'homes#about'
end