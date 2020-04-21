# frozen_string_literal: true

Rails.application.routes.draw do
  # resources :order_details
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

  scope '/checkout' do
    post 'create', to: 'checkout#create', as: 'checkout_create'
    get 'cancel', to: 'checkout#cancel', as: 'checkout_cancel'
    get 'success', to: 'checkout#success', as: 'checkout_success'
  end

  get 'cards', to: 'cards#show', as: 'show'
  get 'about', to: 'pages#about', as: 'about'
  get 'categories', to: 'categories#index', as: 'catindex'
  get 'search', to: 'cards#search', as: 'search'
  get 'orders', to: 'orders#index', as: 'orders_index'
  get 'orders/show', to: 'orders#show', as: 'orders_show'
  get 'order_details', to: 'order_details#index', as: 'review_cart'

  get 'login', to: 'sessions#new'
  post 'login', to: 'sessions#create'
  get 'welcome', to: 'sessions#welcome'
  get 'authorized', to: 'sessions#page_requires_login'

  # routes for cart
  post 'cards/add_to_cart/:id', to: 'cards#add_to_cart', as: 'add_to_cart'
  post 'orders/confirm/', to: 'orders#confirm', as: 'confirm_order'
  post 'order_details/add_quantity/:id', to: 'order_details#add_quantity', as: 'add_quantity'
  post 'order_details/minus_quantity/:id', to: 'order_details#minus_quantity', as: 'minus_quantity'

  delete 'cards/remove_from_cart/:id', to: 'cards#remove_from_cart', as: 'remove_from_cart'
  delete 'order_details/remove_from_details/:id', to: 'order_details#remove_from_details', as: 'remove_from_details'

  root to: 'cards#index'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
