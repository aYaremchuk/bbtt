Rails.application.routes.draw do
  root to: 'home#index'

  devise_for :users

  get 'home/index'

  namespace :admin do
    get '/', to: 'dashboards#index'
  end
end
