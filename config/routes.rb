Rails.application.routes.draw do
  root 'backbone#index'
  get '/auth/facebook/callback', to: 'oauth_callbacks#facebook'
  get '/backbone', to: 'backbone#index'

  resources :posts, only: [:index, :show] do
    resources :likes, only: [:create]
    resources :notes, only: [:create]
    post :reblog
  end

  resources :users do
    get :activate
    post :search, on: :collection
    post :change_blogs
  end

  resources :blogs do
    resources :follows, only: [:create, :index]
    resources :posts, shallow: true
  end

  resources :follows, only: [:destroy]
  resources :likes, only: [:destroy]
  resource :session, only: [:new, :create, :destroy]

  namespace :api, defaults: {format: :json} do
    get '/search', as: :search, to: 'static_pages#search'
    resources :blogs
    resources :users, only: [:index, :show, :create, :update] do
      post :change_blogs
    end
    resources :follows, only: [:index, :create, :destroy]
    resources :posts, only: [:index, :show, :create, :destroy] do
      post :reblog
    end
    resource :likes, only: [:create, :destroy]
    resources :notes, only: [:index, :create, :destroy]
    resource :session, only: [:create, :destroy]
  end

end
