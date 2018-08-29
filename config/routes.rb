require 'sidekiq/web'

Rails.application.routes.draw do
  mount ActionCable.server, at: '/cable'
  root to: 'posts#index'

  get 'home/index'

  devise_for :users, skip: [:registrations]
  as :user do
    get 'users/edit', to: 'devise/registrations#edit', as: 'edit_user_registration'
    put 'users', to: 'devise/registrations#update', as: 'user_registration'
    delete 'users', to: 'devise/registrations#destroy'
  end

  resources :users, except: :index
  resources :posts, only: %i(index show)

  namespace :admin do
    get '/', to: 'dashboards#index'
    resources :users
    resources :posts
    resources :groups
  end

  authenticate :user, ->(user) { user.admin? } do
    mount Sidekiq::Web, at: '/sidekiq', as: 'sidekiq'
  end
end
