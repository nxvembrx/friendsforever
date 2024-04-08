# frozen_string_literal: true

Rails.application.routes.draw do
  devise_for :users, controllers: { registrations: 'users/registrations' }
  root 'static_pages#index'

  resources :memos, except: :index
  get '/timeline' => 'memos#index'

  scope '/settings' do
    get '/profile' => 'profiles#edit', as: 'edit_profile'
    patch '/profile' => 'profiles#update', as: 'profile'
  end

  get '/:username' => 'users#show', as: 'user', username: %r{[^/]+}
end
