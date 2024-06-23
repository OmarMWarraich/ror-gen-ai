Rails.application.routes.draw do
  # get 'sessions/new'
  # get 'registrations/new'
  get 'home/index'
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  resource :session # where login and logout routes are defined
  resource :registration # where signup routes are defined
  resource :password_reset # where password reset routes are defined
  resource :password_change # where password change routes are defined

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Defines the root path route ("/")
  root "home#index"
end
