Rails.application.routes.draw do
  resource :events, only: :create

  resources :issues, only: [] do
    resources :events, only: [:index]
  end
end
