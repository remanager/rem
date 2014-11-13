Rails.application.routes.draw do
  scope '(:locale)', locale: /#{I18n.available_locales.join('|')}/ do
    get 'login' => 'sessions#new', as: 'login'
    get 'logout' => 'sessions#destroy', as: 'logout'

    resources :sessions, only:  [:new, :create, :destroy]
    resources :password_resets, only: [:new, :create, :edit, :update]

    namespace :admin do
      resources :users
      resources :properties do
        delete '/destroy_picture/:picture_id' => 'properties#unpublish_picture', as: 'destroy_picture'
      end
      resources :details
      resources :categories
      resources :realestates
      resources :towns
      get 'dashboard' => 'dashboard#index', as: 'dashboard'
    end

    get 'public/index'
    get '/:realestate_id/search', to: 'public#search', as: 'search'
    post '/:realestate_id/search', to: 'public#search_dirty', as: 'search_dirty'

    get '/:realestate_id', to: 'public#show', as: 'realestate'
    get '/:realestate_id/categories/:id', to: 'public#categories_show', as: 'category'
    get '/:realestate_id/categories', to: 'public#categories_index', as: 'categories'
    get '/:realestate_id/:id', to: 'public#property', as: 'property'

    root 'public#index'
  end

  match '/*locale/admin/*path', to: redirect("/#{I18n.default_locale}/admin/%{path}"), via: :all
  match '/*path', to: redirect("/#{I18n.default_locale}/%{path}"), constraints: lambda { |req| !req.path.starts_with?(I18n.default_locale) }, via: :all
end
