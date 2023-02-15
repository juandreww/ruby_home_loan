Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"

  resources :brands
  resource :users, only: [:sign_up, :sign_in, :successful_sign_up, :forgot_password]
end
