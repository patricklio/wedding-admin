Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  root to:"admin/dashboard#index"

  namespace :admin do
    devise_for :user_accounts,
               skip: [:registrations],
               controllers: { sessions: 'admin/user_accounts/sessions', passwords: 'admin/user_accounts/passwords'},
               path_names: { sign_in: 'login', sign_out: 'logout', password: 'secret', confirmation: 'verification', unlock: 'unblock' }

    patch "update_password", to: "users#update_password", as: "update_user_password"

    get "components", to: "components#index" # TO DELETE AFTER
    get 'dashboard', to: 'dashboard#index'

    # path to create customer user_account
    post 'customer_user_accounts', to: 'customers#create_customer_account'
    resources :users
    resources :customers
    resources :partners
    post "add_partner_user_account", to: "partners#add_partner_user_account"
    resources :repairoption_categories, only: [:index, :destroy, :new, :create, :edit, :update]
    resources :repairoptions, only: [:index, :destroy, :new, :create, :edit, :update]
    get "repairoptions/categories", to: "repairoptions#categories"
    resources :operations
    resources :joboperations, only: [:destroy, :new, :create, :edit, :update, :index]
    resources :jobparts, only: [:destroy, :new, :create, :edit, :update, :index]
    resources :parts, only: [:index, :new, :create, :edit, :update, :destroy]
    resources :info_requests, only: [:index]
  end
end
