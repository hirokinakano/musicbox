Rails.application.routes.draw do
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
  root to: 'toppages#index'
  devise_for :listeners, :controllers => {
    :registrations => 'listeners/registrations',
    :sessions => 'listeners/sessions',
    :omniauth_callbacks => 'listeners/omniauth_callbacks' }
  get 'artists/new'
  get 'sessions/new'
  get    '/login',   to: 'sessions#new'
  post   '/login',   to: 'sessions#create'
  delete '/logout',  to: 'sessions#destroy'
  post   '/artists/new', to: 'artists#create'
  resources :artists
  resources :posts
end

