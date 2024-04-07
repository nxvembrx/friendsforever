# frozen_string_literal: true

Rails.application.routes.draw do
  devise_for :users, controllers: { registrations: 'users/registrations' }
  root 'static_pages#index'

  resources :memos, except: :index
  get '/timeline' => 'memos#index'

  resources :profiles

  get '/:username' => 'users#show', as: 'user', username: %r{[^/]+}
end
