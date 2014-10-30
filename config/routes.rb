Rails.application.routes.draw do
  root 'posts#index'  
  get '/auth/facebook/callback', to: 'oauth_callbacks#facebook'
  
  resources :posts, only: [:index, :show] do
    resources :likes, only: [:create]
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
end
