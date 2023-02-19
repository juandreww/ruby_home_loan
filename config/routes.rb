Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"

  resources :brands

  resources :users
  namespace :users do
    get 'sign_in', to: 'sign_in'
    get 'sign_up', to: 'sign_up'
    post 'new_session', to: 'new_session'
    post 'create', to: 'create'
  end
end
