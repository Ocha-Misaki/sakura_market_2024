Rails.application.routes.draw do
  devise_for :admin, controllers: {
    sessions: 'admin/sessions',
  }

  namespace :admin do
    root 'foods#index'
    resources :foods do
      member do
        patch :move_higher
        patch :move_lower
      end
    end
  end
end
