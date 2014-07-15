Rails.application.routes.draw do
  root 'sessions#new'

  resources :users
  resources :sessions, only:  [:new, :create, :destroy]
  get 'log_in' => 'sessions#new', as: 'log_in'
  get 'log_out' => 'sessions#destroy', as: 'log_out'
end
