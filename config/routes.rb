require 'sidekiq/web'

Rails.application.routes.draw do
  resources :products
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  root "products#index"

  mount Sidekiq::Web => '/sidekiq'

  # devise_for :users, :controllers => { registrations: 'users/registrations' }

  resources :brands
  post "checkout/create", to: "checkout#create"
  get "checkout/pay", to: "checkout#pay"

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
    resources :profile, only: [:show, :edit, :update] do
      member do
        get '/edit_password', to: 'profile#edit_password'
        post '/update_password', to: 'profile#update_password'
        post '/send_telegram', to: 'profile#send_telegram'
        post '/send_telegram_group', to: 'profile#send_telegram_group'
      end
    end
  end

  scope module: 'admin' do
    resources :profile, only: [:show, :edit, :update] do
      member do
        get '/edit_password', to: 'profile#edit_password'
        post '/update_password', to: 'profile#update_password'
        post '/send_telegram', to: 'profile#send_telegram'
        post '/send_telegram_group', to: 'profile#send_telegram_group'
      end

      collection do
        get 'telegram_profile', to: 'profile#telegram_profile'
      end
    end

    resource :qr_code do
      collection do
        get '/generator', to: 'qr_codes#generator'
        post '/download', to: 'qr_codes#download'
      end
    end
  end

  get 'download', to: "profile#download"
end
