# frozen_string_literal: true

require 'sidekiq/web'

Sidekiq::Web.use ActionDispatch::Cookies
Sidekiq::Web.use ActionDispatch::Session::CookieStore, key: '_interslice_session'

Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  mount Sidekiq::Web, at: '/rails/admin/sidekiq'

  namespace :api, defaults: { format: :json } do
    namespace :v1 do
      # api test action
      # TEST:こちらテストで作ったroute
      resources :hellos, only: %i[index update destroy]
      resources :todos, only: %i[index update]
      resources :firebase_authentications, only: %i[index update] do
        collection do
          post 'auth_with_firebase'
        end
      end
      resources :profiles do
        collection do
          get 'user'
        end
      end
    end
  end
end
