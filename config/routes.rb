Rails.application.routes.draw do

  devise_for :users, :path_prefix => 'my'

  authenticate :user do
    resources :famorgs
    resources :users
    resources :comments
  end

  authenticated :user do
    root 'famorgs#index', as: :authenticated_root
  end

  root 'home#splash'

  get 'splash', to: 'home#splash', as: :splash

  get 'invite_users', to: 'home#invite_users', as: :invite_users

  get 'email_sent', to: 'home#email_sent', as: :email_sent

  get 'famorgs/:famorg_id/assign', to: 'famorgs#assign', as: :assign

  get 'famorgs/:famorg_id/group_invite', to: 'famorgs#group_invite', as: :group_invite

  resources :groups



end
