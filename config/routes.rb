Rails.application.routes.draw do
  ActiveAdmin.routes(self)
  devise_for :users, controllers: {
    omniauth_callbacks: 'users/omniauth_callbacks',
    sessions: 'users/sessions',
  }
  root to: 'home#index'
  get '/health', to: 'home#health'

  resources :rounds, only: :show do
    collection do
      get :group
      get :knockout
    end
  end

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
  resources :users, only: %i(index show)  do
    collection do
      get :me
    end
  end
end
