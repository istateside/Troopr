Rails.application.routes.draw do
  root 'posts#index'  
  
  resources :posts, only: [:index, :show] do
    resources :likes, only: [:create]
    post :reblog
  end
  
  resources :users do
    resources :blogs, shallow: true 
    get :activate
    post :search, on: :collection
    post :change_blogs
  end
  
  resources :blogs do
    resources :follows, only: [:create, :index]
    resources :posts, except: [:index, :show]
  end
  
  resources :follows, only: [:destroy]
  resources :likes, only: [:destroy]
  resource :session, only: [:new, :create, :destroy]
end
