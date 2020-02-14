Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
<<<<<<< HEAD

  root to: 'components#index'
=======
  root to:"admin/components#index"

  namespace :admin do
    get "components", to: "components#index"
  end
>>>>>>> dev-sprint2
end
