Rails.application.routes.draw do

  get 'chats/show'
  devise_for :users

  resources :users, only: [:show,:index,:edit,:update] do
    get :followings, on: :member
    get :followers, on: :member
  end
  resources :relationships, only: [:create, :destroy]
  resources :books do
    resource :favorites, only: [:create, :destroy]
    resources :book_comments, only: [:create, :destroy]
  end

  root 'homes#top'
  get 'home/about' => 'homes#about'
  get '/search', to: 'searchs#search'
  get 'chat/:id', to: 'chats#show', as: 'chat'
  resources :chats, only: [:create]
  resources :groups, except: [:destroy]

end