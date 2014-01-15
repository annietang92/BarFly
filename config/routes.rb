Barfly::Application.routes.draw do
  root 'static_pages#index'

  resources :users
  resources :sessions, only: [:new, :create, :destroy]

  match '/signup',  to: 'users#new',            via: 'get'
  match '/signin',  to: 'sessions#new',         via: 'get'
  match '/signout', to: 'sessions#destroy',     via: 'delete'

  match 'auth/:provider/callback',  to: 'sessions#fb_create', via: 'get'
  match 'auth/failure',             to: 'static_pages#index', via: 'get'

end
