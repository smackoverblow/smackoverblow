Rails.application.routes.draw do
  ActiveAdmin.routes(self)
  root                      'static_pages#home'
  get                       'votes/create'
  get                       'votes/destroy'
  get                       'posts/create'
  get                       'posts/update'
  get                       'posts/destroy'
  get     '/signup',    to: 'users#new'
  post    '/signup',    to: 'users#create'
  get     '/login',     to: 'sessions#new'
  post    '/login',     to: 'sessions#create'
  delete  '/logout',    to: 'sessions#destroy'
  get     '/rating_p',  to: 'static_pages#rating'
  get     '/rating_v',  to: 'static_pages#rating_votes'
  resources :users do
    member do
      get :following, :followers, :questions, :answers
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
      patch :accept_answer
    end
  end
end
