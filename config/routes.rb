Rails.application.routes.draw do
  get 'prototypes/index'
  devise_for :users
  root to: "prototypes#index"
  resources :users, only: [:show]
  resources :prototypes, only: [:new, :create, :show, :edit, :update, :destroy] do
    resources :comments, only: [:create]
  end
  # get 'prototype/index'
end
