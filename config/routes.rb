Rails.application.routes.draw do
  root 'foods#index'
  resources :foods, only: %i[index show]
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
