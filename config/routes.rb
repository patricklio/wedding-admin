Rails.application.routes.draw do
  devise_for :user_accounts
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  root to:"admin/components#index"
  namespace :admin do
    get "components", to: "components#index"
  end
end

