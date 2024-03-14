Rails.application.routes.draw do
  root 'foods#index'

  devise_for :users, controllers: {
    registrations: 'users/registrations',
    sessions: 'users/sessions',
    passwords: 'users/passwords',
    confirmations: 'users/confirmations',
  }
  devise_for :admin, controllers: {
    sessions: 'admin/sessions',
  }

  resource :address, only: %i[new create show edit update]
  resource :cart, only: %i[show] do
    resources :cart_items, only: %i[create update destroy], module: :cart
  end
  resources :foods, only: %i[index show]
  resources :orders, only: %i[index new create show]
  resources :posts, only: %i[index new create edit update destroy] do
    resource :like, only: %i[create destroy], module: :posts
    resources :comments, only: %i[index new create edit update destroy], module: :posts
  end

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

  if Rails.env.development?
    mount LetterOpenerWeb::Engine, at: '/letter_opener'
  end
end
