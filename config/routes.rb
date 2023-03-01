Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
  namespace :user do
    resources :sleep_logs, only: %i[index create]
    resources :followings, only: %i[create destroy] do
      get :sleep_logs, on: :collection
    end
  end
end
