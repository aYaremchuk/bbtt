Rails.application.routes.draw do
  root to: 'home#index'

  get 'home/index'

  devise_for :users, skip: [:registrations]
  as :user do
    get 'users/edit' => 'devise/registrations#edit', :as => 'edit_user_registration'
    put 'users' => 'devise/registrations#update', :as => 'user_registration'
    delete 'users' => 'devise/registrations#destroy'
  end

  resources :users, except: :index
  resources :posts, only: %i(index show)

  namespace :admin do
    get '/', to: 'dashboards#index'
    resources :users
    resources :posts
    resources :groups
  end
end
