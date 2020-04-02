# frozen_string_literal: true

Rails.application.routes.draw do
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
  resources :cards

  get 'cards', to: 'cards#show', as: 'show'
  get 'about', to: 'pages#about', as: 'about'

  root to: 'cards#index'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
