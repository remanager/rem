Rails.application.routes.draw do
  root 'sessions#new'

  get 'login' => 'sessions#new', as: 'login'
  get 'logout' => 'sessions#destroy', as: 'logout'

  resources :sessions, only:  [:new, :create, :destroy]
  resources :password_resets, only: [:new, :create, :edit, :update]

  namespace :admin do
    resources :users
  end
end
