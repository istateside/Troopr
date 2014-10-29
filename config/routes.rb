Rails.application.routes.draw do
  root 'posts#index'  
  
  resources :posts, only: [:index, :show] do
    resources :likes, only: [:create]
  end
  resources :users do
    resources :follows, only: [:create, :index]
    resources :posts, except: [:index, :show]
    get :activate
  end
  
  resources :follows, only: [:destroy]
  resources :likes, only: [:destroy]
  resource :session, only: [:new, :create, :destroy]

end
