Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  root to:"admin/components#index"

  namespace :admin do
    get "components", to: "components#index" # TO DELETE AFTER

    resources :repairoption_categories, only: [:index, :destroy, :new, :create, :edit]
  end
end

