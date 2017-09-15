Rails.application.routes.draw do

  scope :api do
    resources :votings do
      scope module: :votings do
        resource :preferences, only: %i[create]
      end
    end
  end
end
