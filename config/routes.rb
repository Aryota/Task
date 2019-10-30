Rails.application.routes.draw do
  root to: 'tasks#index'
  resources :tasks
  get '*not_found' => 'application#routing_error'
  post '*not_found' => 'application#routing_error'
    # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
