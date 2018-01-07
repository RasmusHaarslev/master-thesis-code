Rails.application.routes.draw do

  get 'index' => 'application#index', as: 'index'

  scope :api do
    resources :votings do
      scope module: :votings do
        resource :preferences, only: %i[show create]
        resource :kemenies, only: %i[show]
        resource :schulzes, only: %i[show]
        resource :rankeds, only: %i[show]
      end
    end
  end
end
