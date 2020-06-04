Rails.application.routes.draw do
  resources :dashboards
  devise_for :users

  root to: 'dashboards#index'
end
