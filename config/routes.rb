Rails.application.routes.draw do

  resources :users do
    resources :dishes, only: [:show, :index, :new, :create, :edit, :destroy] do
      post '/tasted' => 'list_items#tasted'
    end
  end
  # resources :sessions, only: [:new, :create, :destroy]

  get '/login' => 'sessions#new'
  post '/login' => 'sessions#create'
  post '/logout' => 'sessions#destroy'

  # post '/users/:user_id/dishes/:id' => 'dish#update_status'

  resources :list_items, only: [:create, :destroy]
  resources :lists, only: [:show, :index]
  # get '/lists/all', to: "lists#all_lists"

  resources :dishes, except: [:new, :edit, :update, :destroy]

  resources :restaurants, except: [:new, :edit, :update, :destroy] do
    # resources :dishes, only: [:show, :index, :new, :create]
  end

  root 'welcome#index'
  get '/welcome' => 'welcome#home'

  get '/must-trys' => 'dishes#popular'

end
