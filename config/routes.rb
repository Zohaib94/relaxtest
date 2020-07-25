# frozen_string_literal: true

Rails.application.routes.draw do
  devise_for :admin_users, ActiveAdmin::Devise.config

  ActiveAdmin.routes(self)

  resources :log_receipts, only: %i[index show]

  devise_for :users

  root to: 'log_receipts#index'
end
