Rails.application.routes.draw do

  devise_for :users, :path_prefix => 'my'
  resources :famorgs
  resources :users

  resources :comments
get 'assign', to: 'home#assign', as: :assign
root to: 'home#index'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
