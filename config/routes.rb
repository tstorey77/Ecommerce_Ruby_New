# frozen_string_literal: true

Rails.application.routes.draw do
  resources :order_details
  resources :orders
  get 'sessions/new'
  get 'sessions/create'
  get 'sessions/login'
  get 'sessions/welcome'
  resources :provinces
  resources :users, only: %i[new create]
  resources :categories
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
  resources :cards

  get 'cards', to: 'cards#show', as: 'show'
  get 'about', to: 'pages#about', as: 'about'
  get 'categories', to: 'categories#index', as: 'catindex'
  get 'search', to: 'cards#search', as: 'search'
  get 'orders', to: 'orders#index', as: 'ordersindex'

  get 'login', to: 'sessions#new'
  post 'login', to: 'sessions#create'
  get 'welcome', to: 'sessions#welcome'
  get 'authorized', to: 'sessions#page_requires_login'

  # routes for cart
  post 'cards/add_to_cart/:id', to: 'cards#add_to_cart', as: 'add_to_cart'
  post 'orders/buy_now/', to: 'orders#index', as: 'buy_now'
  delete 'cards/remove_from_cart/:id', to: 'cards#remove_from_cart', as: 'remove_from_cart'
  delete 'order_details/remove_from_details/:id', to: 'order_details#remove_from_details', as: 'remove_from_details'

  root to: 'cards#index'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
