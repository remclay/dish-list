Rails.application.routes.draw do

  get '/login' => 'sessions#new'
  post '/sessions' => 'sessions#create'
  post '/logout' => 'sessions#destroy'

  get '/auth/facebook/callback' => 'sessions#create'
  get "/auth/github/callback" => 'sessions#create'

  root 'welcome#index'
  get '/welcome' => 'welcome#home'

  resources :list_items, only: [:create, :destroy]
  resources :lists, only: [:show, :index]
  resources :dishes, only: [:show, :index, :create]
  resources :restaurants, only: [:show, :index, :create]

  resources :users, except: [:edit, :update, :destroy] do
    resources :dishes, only: [:show, :index, :new] do
      post '/tasted' => 'list_items#tasted'
    end
  end

  get '/most_popular' => 'dishes#popular'
  get '/most_popular/restaurants' => 'restaurants#popular'

end
