Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  root to:"admin/components#index"
  namespace :admin do
    get "components", to: "components#index"

    as :user_accounts do
      get 'user_accounts/edit', to:'users#edit', as: :edit_user_profile
      put 'user_accounts', to:'users#update', as: :update_user_profile
    end

    devise_for :user_accounts,
               skip: [:registrations],
               controllers: {
                   sessions: 'user_accounts/sessions',
                   passwords: 'user_accounts/passwords'
               },
               path_names: {
                   sign_in: 'login',
                   sign_out: 'logout',
                   password: 'secret',
                   confirmation: 'verification',
                   unlock: 'unblock'
               }
  end
end

