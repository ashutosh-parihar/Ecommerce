Rails.application.routes.draw do
  get 'admin/index'
  get 'products/index'
  root 'homes#index'
  resources :homes do
    get 'search', on: :collection
  end
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
    resources :carts, only: [:index, :new, :create, :destroy, :show, :update]
    resources :products
    resources :orders
  end
end
