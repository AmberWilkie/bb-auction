Rails.application.routes.draw do
  devise_for :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  resources :users, only: [:index, :show]

  namespace :users do
    namespace :products do
      resources :bids, only: [:create] do
        post 'accept', on: :member
      end
    end
  end
  root to: 'users#index'
end
