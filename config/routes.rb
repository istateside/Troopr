Rails.application.routes.draw do
  root 'posts#index'

  resources :posts, only: [:index, :show]

  resources :users do
    resources :posts, except: [:index, :show]
  end
  
  resource :session, only: [:new, :create, :destroy]

end
