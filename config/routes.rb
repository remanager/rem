Rails.application.routes.draw do
  root 'sessions#new'

  get 'log_in' => 'sessions#new', as: 'log_in'
  get 'log_out' => 'sessions#destroy', as: 'log_out'

  resources :sessions, only:  [:new, :create, :destroy]

  namespace :admin do
    resources :users
  end
end
