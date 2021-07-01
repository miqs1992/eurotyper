Rails.application.routes.draw do
  ActiveAdmin.routes(self)
  devise_for :users
  root to: 'home#index'

  resources :rounds, only: :show
  resources :match_days, only: :show do
    collection do
      get :last
      get :next
    end
    member do
      put :update_bets
    end
  end

  resources :players, only: :index
  resources :users, only: :index  do
    collection do
      get :me
    end
  end
end
