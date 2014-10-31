Rails.application.routes.draw do
  root 'posts#index'  
  get '/auth/facebook/callback', to: 'oauth_callbacks#facebook'
  
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
    resources :follows
    resources :posts
    resources :likes    
    resources :notes    
  end
  
end
