Rails.application.routes.draw do
  namespace :admin do
    get 'joboperations/index'
    get 'joboperations/new'
    get 'joboperations/create'
    get 'joboperations/edit'
    get 'joboperations/update'
    get 'joboperations/delete'
  end
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  root to:"admin/components#index"

  namespace :admin do
    get "components", to: "components#index" # TO DELETE AFTER

    resources :users
    resources :repairoption_categories, only: [:index, :destroy, :new, :create, :edit, :update]
    resources :repairoptions
    resources :joboperations, only: [:destroy, :new, :create, :edit, :update]

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

    resources :users, only: [:edit, :update]
    patch "update_password", to: "users#update_password", as: "update_user_password"
  end
end

