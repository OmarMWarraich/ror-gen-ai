require "sidekiq/web"

Rails.application.routes.draw do

  get "account" => "account_manager#index", as: :account_manager
  post '/create_portal_session' => 'account_manager#create_portal_session', as: :create_portal_session

  post "stripe_webhook" => "stripe_webhooks#webhook"

  get "pricing" => "subscriptions#index"
  post "create_checkout_session" => "subscriptions#create_checkout_session", as: :create_checkout_session
  get "success" => "subscriptions#success"


  # if defined?(Sidekiq::Web)
  #   mount Sidekiq::Web => "/sidekiq"
  # end
  mount Sidekiq::Web => "/sidekiq"
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  resource :session # where login and logout routes are defined
  resource :registration # where signup routes are defined
  resource :password_reset # where password reset routes are defined
  resource :password_change # where password change routes are defined
  resource :txt2_imgs, only: [:index, :create] # where the main app routes are defined
  resources :generated_images, only: [:show, :destroy] # where the generated images routes are defined

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Defines the root path route ("/")
  root "txt2_imgs#index"
end
