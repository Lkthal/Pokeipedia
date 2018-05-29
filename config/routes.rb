Rails.application.routes.draw do

  resources :users
  resources :wikis
  devise_for :users
  resources :premiums, only: [:new, :create]
  get 'premiums/create'
  post 'premiums/downgrade' => 'premiums#downgrade'

  root 'welcome#index'
  get 'about' => 'welcome#about'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
