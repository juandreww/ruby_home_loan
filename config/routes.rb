Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"

  resources :brands

  resource :users
  namespace :users do
    get 'sign_in', to: "sign_in"
  end
end
