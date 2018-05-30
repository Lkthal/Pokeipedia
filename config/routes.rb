Rails.application.routes.draw do

  resources :users
  resources :wikis
  devise_for :users
  get 'charges/create'
  post 'users/downgrade' => 'users#downgrade'
  resources :charges, only: [:new, :create]

  root 'welcome#index'
  get 'about' => 'welcome#about'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
