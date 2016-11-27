Rails.application.routes.draw do

  resources :seasons do
    resources :users
  end

root to: 'home#index'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
