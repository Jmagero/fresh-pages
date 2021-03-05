Rails.application.routes.draw do
  resources :users
  get '/signup', to: 'users#new'
  get 'login', to: 'sessions#new'
  post 'login', to: 'sessions#create'
  get 'welcome', to: 'sessions#welcome'
  resources :categories

  root to: "users#index"


  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
