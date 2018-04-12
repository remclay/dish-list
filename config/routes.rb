Rails.application.routes.draw do

  resources :users do
    resources :dishes, only: [:show, :index, :new, :create, :edit, :destroy]
  end
  # resources :sessions, only: [:new, :create, :destroy]

  get '/login' => 'sessions#new'
  post '/login' => 'sessions#create'
  post '/logout' => 'sessions#destroy'

  resources :list_items, only: [:create, :destroy]
  resources :lists, only: [:show, :index]
  # get '/lists/all', to: "lists#all_lists"

  resources :dishes, except: [:new, :edit, :update, :destroy]

  resources :restaurants, except: [:new, :edit, :update, :destroy] do
    resources :dishes, only: [:show, :index, :new, :create]
  end

  root to: 'welcome#index'
end
