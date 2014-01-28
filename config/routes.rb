Barfly::Application.routes.draw do
  root 'static_pages#index'

  resources :users do
    member do
      get :following, :followers
    end
  end
  resources :drinks
  resources :beers
  resources :cocktails
  resources :venues
  resources :sessions, only: [:new, :create, :destroy]
  resources :relationships, only: [:create, :destroy]
  resources :cocktail_like_relationships, only: [:create, :destroy]
  resources :venue_like_relationships, only: [:create, :destroy]
  resources :beer_like_relationships, only: [:create, :destroy]

  match '/top',  to: 'static_pages#top', via: 'get'
  match '/venues/search',  to: 'venues#search', via: 'post'
  match '/venues/search',  to: 'venues#search', via: 'get'
  match '/signup',  to: 'users#new',            via: 'get'
  match '/signin',  to: 'sessions#new',         via: 'get'
  match '/signout', to: 'sessions#destroy',     via: 'delete'
  match '/error', to: 'static_pages#404',     via: 'get'

  match 'auth/:provider/callback',  to: 'sessions#fb_create', via: 'get'
  match 'auth/failure',             to: 'static_pages#index', via: 'get'

  match '/fb', to: 'facebook#index',     via: 'get'
  match '/passport', to: 'static_pages#passport',     via: 'get'

end
