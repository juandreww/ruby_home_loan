require 'sidekiq/web'

Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"

  mount Sidekiq::Web => '/sidekiq'

  resources :brands

  namespace :users do
    get 'sign_in', to: 'sign_in'
    get 'sign_up', to: 'sign_up'
    post 'new_session', to: 'new_session'
    post 'create', to: 'create'
    post 'send_otp_code', to: 'send_otp_code'
  end
end
