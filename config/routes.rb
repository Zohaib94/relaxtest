# frozen_string_literal: true

Rails.application.routes.draw do
  resources :dashboards, except: [:show] do
    collection do
      get :preview
    end

    member do
      patch :sort
    end
  end

  devise_for :users

  root to: 'dashboards#index'
end
