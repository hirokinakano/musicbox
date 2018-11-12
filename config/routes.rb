Rails.application.routes.draw do
  devise_for :listeners, :controllers => {
    :registrations => 'listeners/registrations',
    :sessions => 'listeners/sessions'}
  get 'artists/new'
  get 'sessions/new'
  root to: 'toppages#index'
  get    '/signup',  to: 'users#new'
  post   '/signup',  to: 'users#create'
  get    '/login',   to: 'sessions#new'
  post   '/login',   to: 'sessions#create'
  delete '/logout',  to: 'sessions#destroy'
  post   '/artists/new', to: 'artists#create'
  resources :users
  resources :artists
end
