Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  root to:"admin/components#index"

  namespace :admin do
    devise_for :user_accounts,
               skip: [:registrations],
               controllers: {
                   sessions: 'admin/user_accounts/sessions',
                   passwords: 'admin/user_accounts/passwords'
               },
              path_names: {
                  sign_in: 'login',
                  sign_out: 'logout',
                  password: 'secret',
                  confirmation: 'verification',
                  unlock: 'unblock'
              }
    patch "update_password", to: "users#update_password", as: "update_user_password"

    get "components", to: "components#index" # TO DELETE AFTER


    resources :users
    resources :repairoption_categories, only: [:index, :destroy, :new, :create, :edit, :update]
    resources :repairoptions, only: [:index, :destroy, :new, :create, :edit, :update]
    get "repairoptions/categories", to: "repairoptions#categories"
    resources :operations
    resources :joboperations, only: [:destroy, :new, :create, :edit, :update]
    resources :jobparts, only: [:destroy, :new, :create, :edit, :update]
    resources :partners
  end
end
