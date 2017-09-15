Rails.application.routes.draw do
  resources :votings do
    scope module: :votings do
      resource :preferences, :only => %i[create]
    end
  end
end
