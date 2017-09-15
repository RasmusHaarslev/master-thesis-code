Rails.application.routes.draw do

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root 'frontend#index'
  get "frontend",       controller: "frontend", action: "index"
  get "frontend/*path", controller: "frontend", action: "index"


  scope :api do
    resources :votings do
      scope module: :votings do
        resource :preferences, only: %i[create]
      end
    end
  end
end
