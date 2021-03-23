Rails.application.routes.draw do
  resources :users
  get '/signup', to: 'users#new'
  get 'login', to: 'sessions#new'
  post 'login', to: 'sessions#create'
  get '/logout',  to: 'sessions#destroy'

  resources :categories
  resources :articles, except: [:destroy]  do
    resources :votes, except: [:destroy]
  end

  root to: "categories#home"


  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
