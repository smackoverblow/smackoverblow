Rails.application.routes.draw do
  get 'votes/create'

  get 'votes/destroy'

  get 'posts/create'

  get 'posts/update'

  get 'posts/destroy'

  root    'static_pages#home'
  get     '/contacts',  to: 'static_pages#contacts'
  get     '/about',     to: 'static_pages#about'
  get     '/help',      to: 'static_pages#help'
  get     '/signup',    to: 'users#new'
  post    '/signup',    to: 'users#create'
  # patch   '/users/:id/edit',       to: 'users#update'
  get     '/login',     to: 'sessions#new'
  post    '/login',     to: 'sessions#create'
  delete  '/logout',    to: 'sessions#destroy'
  post    '/vote_up',   to: 'votes#create'
  post    '/vote_down', to: 'votes#create'
  resources :users do
    member do
      get :following, :followers, :questions
    end
  end
  resources :account_activations, only: [:edit]
  resources :password_resets,     only: [:new, :create, :edit, :update]
  resources :relationships,       only: [:create, :destroy]
  resources :votes,               only: [:create, :destroy]
  resources :posts,               path: 'questions'
  resources :posts do
    member do
      get :answer, :votes
    end
  end


end
