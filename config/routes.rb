Rails.application.routes.draw do
  resources :votings do
    member do
      post 'preference'
    end
  end
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
