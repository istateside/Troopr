Rails.application.routes.draw do
  devise_for :users

  root 'posts#index'

  resources :posts, only: [:index]

  resources :users do
    resources :posts, except: [:index]
  end

end
