require 'sidekiq/web'

Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"

  mount Sidekiq::Web => '/sidekiq'

  resources :brands

  namespace :users do
    get 'verification', to: 'verification'
    get 'sign_in', to: 'sign_in'
    get 'sign_up', to: 'sign_up'
    post 'new_session', to: 'new_session'
    post 'create', to: 'create'
    post 'send_otp_code', to: 'send_otp_code'
    post 'verify', to: 'verify'
  end

  namespace :home_loans do
    get 'new', to: 'new'
    post 'calculate', to: 'calculate'
    get 'reset', to: 'reset'
    get 'print_pdf', to: 'print_pdf'
    post 'print_pdf', to: 'print_pdf'
  end

  namespace :admin do
    resources :profile, only: [:show, :edit, :update]
  end

  scope module: 'admin' do
    resources :profile, only: [:show, :edit, :update]
  end

  get 'download', to: "profile#download"
end
