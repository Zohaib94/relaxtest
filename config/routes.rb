Rails.application.routes.draw do
  resources :dashboards do
    collection do
      get :preview
    end
  end

  devise_for :users

  root to: 'dashboards#index'
end
