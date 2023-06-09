Rails.application.routes.draw do
  get 'admin/index'
  get 'products/index'
  root 'homes#index'
  resources :homes
  resources :products
  devise_for :users, controllers: {
    sessions: 'users/sessions',
    registrations:'users/registrations'
  }
  namespace :admin do
    resources :users
  end


  namespace :supplier do
    resources :products, only: [:index]
  end


  namespace :customer do
    get 'products/index'
    resources :carts
    resources :products
  end
end
