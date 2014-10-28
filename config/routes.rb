Rails.application.routes.draw do
  root 'posts#index'

  resources :posts, only: [:index, :show]

  resources :users do
    resources :follows, only: [:create, :index]
    resources :posts, except: [:index, :show]
  end
  
  resources :follows, only: [:destroy]
  
  resource :session, only: [:new, :create, :destroy]

end
