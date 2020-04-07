# frozen_string_literal: true

Rails.application.routes.draw do
  resources :categories
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
  resources :cards

  get 'cards', to: 'cards#show', as: 'show'
  get 'about', to: 'pages#about', as: 'about'
  get 'categories', to: 'categories#index', as: 'catindex'
  get 'search', to: 'cards#search', as: 'search'

  # routes for cart
  post 'cards/add_to_cart/:id', to: 'cards#add_to_cart', as: 'add_to_cart'
  delete 'cards/remove_from_cart/:id', to: 'cards#remove_from_cart', as: 'remove_from_cart'

  root to: 'cards#index'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
