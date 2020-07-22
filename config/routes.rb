# frozen_string_literal: true

Rails.application.routes.draw do
  devise_for :admin_users, ActiveAdmin::Devise.config

  ActiveAdmin.routes(self)

  resources :dashboards, except: [:show] do
    collection do
      get :preview
    end

    member do
      patch :sort
    end
  end

  resources :log_receipts, only: %i[index show]

  devise_for :users

  root to: 'log_receipts#index'
end
