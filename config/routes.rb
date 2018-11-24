Rails.application.routes.draw do
  root to: 'toppages#index'
  devise_for :listeners, :controllers => {
    :registrations => 'listeners/registrations',
    :sessions => 'listeners/sessions'}
  get 'artists/new'
  get 'sessions/new'
  get    '/login',   to: 'sessions#new'
  post   '/login',   to: 'sessions#create'
  delete '/logout',  to: 'sessions#destroy'
  post   '/artists/new', to: 'artists#create'
  resources :artists
  resources :posts, only: [:create, :destroy]
end
