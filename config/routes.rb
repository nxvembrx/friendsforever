# frozen_string_literal: true

Rails.application.routes.draw do
  devise_for :users, controllers: { registrations: 'users/registrations' }
  root 'static_pages#index'

  resources :memos, except: :index
  # TODO: Move this into the resource
  get '/timeline' => 'memos#index'
  post '/bookmark/:id' => 'memos#bookmark', as: 'bookmark'
  delete '/bookmark/:id' => 'memos#unbookmark', as: 'unbookmark'

  resources :bookmarks, only: %i[index]

  scope '/settings' do
    get '/profile' => 'profiles#edit', as: 'edit_profile'
    patch '/profile' => 'profiles#update', as: 'profile'
  end

  delete '/unfriend/:id' => 'user_friendship#destroy', as: 'unfriend'
  post '/invite/:id' => 'user_friendship#create', as: 'invite_friend'

  get '/:username' => 'users#show', as: 'user', username: %r{[^/]+}
end
