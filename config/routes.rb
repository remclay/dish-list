Rails.application.routes.draw do

  resources :users
  resources :sessions, only: [:new, :create, :destroy]

  resources :list_items, only: [:create, :destroy]
  resources :lists, only: [:show, :index]
  # get '/lists/all', to: "lists#all_lists"

  resources :dishes, except: [:edit, :update, :destroy]

  resources :restaurants, except: [:edit, :update, :destroy] do
    resources :dishes, only: [:show, :index, :new, :create]
  end

  root to: 'welcome#index'
end
