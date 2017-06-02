Rails.application.routes.draw do
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
  resources :users do
    member do
      get :following, :followers, :questions
    end
  end
  resources :account_activations, only: [:edit]
  resources :password_resets,     only: [:new, :create, :edit, :update]
  resources :microposts,          only: [:create, :destroy]
  resources :relationships,       only: [:create, :destroy]
  resources :posts,               path: 'questions'
  resources :posts do
    member do
      get :answer
    end
  end


end
