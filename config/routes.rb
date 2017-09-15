Rails.application.routes.draw do

  get 'index' => 'application#index', as: 'index'

  scope :api do
    resources :votings do
      scope module: :votings do
        resource :preferences, only: %i[create]
      end
    end
  end
end
