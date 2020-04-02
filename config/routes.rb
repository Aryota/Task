Rails.application.routes.draw do
  get 'posts/index'
  get 'posts/show'
  get '/login', to: 'sessions#new'
  post '/login', to: 'sessions#create'
  delete '/logout', to: 'session#destroy'

  namespace :admin do
    resources :users
  end
  root to: 'tasks#index'
  resources :tasks do
    post :confirm, action: :confirm_new, on: :new
    post :import, on: :collection
  end
  resources :posts, only: [:index, :show, :create]
  resources :tasks
    # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
