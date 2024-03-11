Rails.application.routes.draw do
  root 'foods#index'
  resources :foods, only: %i[index show]
  resource :cart, only: %i[show] do
    resources :cart_items, only: %i[create edit update destroy], module: :cart
  end
  resources :orders, only: %i[index new create show]

  resource :address, only: %i[new create show edit update destroy]

  devise_for :users, controllers: {
    registrations: 'users/registrations',
    sessions: 'users/sessions',
    passwords: 'users/passwords',
    confirmations: 'users/confirmations',
  }

  devise_for :admin, controllers: {
    sessions: 'admin/sessions',
  }

  mount LetterOpenerWeb::Engine, at: '/letter_opener'

  namespace :admin do
    root 'foods#index'
    resources :foods do
      member do
        patch :move_higher
        patch :move_lower
      end
    end
    resources :users, only: %i[index show edit update destroy]
  end
end
