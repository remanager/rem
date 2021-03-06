Rails.application.routes.draw do
  scope '(:locale)', locale: /#{I18n.available_locales.join('|')}/ do
    get 'login' => 'sessions#new', as: 'login'
    get 'logout' => 'sessions#destroy', as: 'logout'

    resources :sessions, only:  [:new, :create, :destroy]
    resources :password_resets, only: [:new, :create, :edit, :update]

    namespace :admin do
      resources :users, except: [:show] do
        member do
          get :approve
          get :ban
        end
      end
      resources :properties do
        delete '/destroy_picture/:picture_id' => 'properties#unpublish_picture', as: 'destroy_picture'
        member do
          get 'publish'
        end
      end
      resources :details
      resources :categories
      resources :realestates do
        member do
          get 'publish'
          get 'unpublish'
        end
      end
      resources :towns
      resources :comments do
        member do
          get 'publish'
          get 'unpublish'
          get 'seen'
        end
      end
      get '/' => 'dashboard#index', as: 'dashboard'
    end

    get 'public/index'
    post '/create_agent', to: 'public#create_agent', as: 'create_agent'
    get '/:realestate_id/search', to: 'public#search', as: 'search'
    post '/:realestate_id/search', to: 'public#search_dirty', as: 'search_dirty'

    post '/:realestate_id/(:property_id)/comment', to: 'public#add_comment', as: 'add_comment'
    get '/:realestate_id', to: 'public#show', as: 'realestate'
    get '/:realestate_id/categories/:id', to: 'public#categories_show', as: 'category'
    get '/:realestate_id/categories', to: 'public#categories_index', as: 'categories'
    get '/:realestate_id/:id', to: 'public#property', as: 'property'

    root 'public#index'
  end

  match '/*locale/admin/*path', to: redirect("/#{I18n.default_locale}/admin/%{path}"), via: :all
  match '/*path', to: redirect("/#{I18n.default_locale}/%{path}"), constraints: lambda { |req| !req.path.starts_with?(I18n.default_locale) }, via: :all
end
