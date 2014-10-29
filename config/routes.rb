Rails.application.routes.draw do
  root 'posts#index'  
  
  resources :posts, only: [:index, :show] do
    resources :reblogs, only: [:create, :destroy]
  end
  resources :users do
    resources :follows, only: [:create, :index]
    resources :posts, except: [:index, :show]
    get :activate, on: :collection
  end
  
  resources :follows, only: [:destroy]
  
  resource :session, only: [:new, :create, :destroy]

end
