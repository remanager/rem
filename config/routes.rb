Rails.application.routes.draw do
  scope '(:locale)', locale: /#{I18n.available_locales.join('|')}/ do
    get 'login' => 'sessions#new', as: 'login'
    get 'logout' => 'sessions#destroy', as: 'logout'

    resources :sessions, only:  [:new, :create, :destroy]
    resources :password_resets, only: [:new, :create, :edit, :update]

    namespace :admin do
      resources :users
      resources :properties
      resources :details
      resources :categories
      resources :realestates
      resources :towns
      get 'dashboard' => 'dashboard#index', as: 'dashboard'
    end

    get 'public/index'
    get '/:id', to: 'public#show', as: 'realestate'
    get '/:realestate_id/:id', to: 'public#property', as: 'property'
    get '/:realestate_id/category/:id', to: 'public#category', as: 'category'
    match '/:realestate_id/search', to: 'public#search', as: 'search', via: [:get, :post]

    root 'public#index'
  end

  match '/*locale/admin/*path', to: redirect("/#{I18n.default_locale}/admin/%{path}"), via: :all
  match '/*path', to: redirect("/#{I18n.default_locale}/%{path}"), constraints: lambda { |req| !req.path.starts_with?(I18n.default_locale) }, via: :all
end
