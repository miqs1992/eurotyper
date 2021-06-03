Rails.application.routes.draw do
  ActiveAdmin.routes(self)
  devise_for :users
  root to: 'home#index'

  resources :match_days, only: [] do
    collection do
      get :last
      get :next
    end
    member do
      put :update_bets
    end
  end
end
