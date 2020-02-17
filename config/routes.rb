Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  root to:"admin/components#index"
  namespace :admin do
    get "components", to: "components#index"

    devise_for :user_accounts, skip: [:registrations], controllers: { sessions: 'admin/user_accounts/sessions', passwords: 'admin/user_accounts/passwords' },
    path_names: { sign_in: 'login', sign_out: 'logout', password: 'secret', confirmation: 'verification', unlock: 'unblock' }
  end
end

