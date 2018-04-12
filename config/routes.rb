Rails.application.routes.draw do
  resources :list_items, only: [:create, :destroy]
  resources :lists, only: [:show, :index]
  # get '/lists/all', to: "lists#all_lists"
  resources :dishes, except: [:edit, :update, :destroy]

  resources :restaurants, except: [:edit, :update, :destroy] do
    resources :dishes, only: [:show, :index, :new, :create]
  end


  # devise_for :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  devise_for :users, :controllers => { :omniauth_callbacks => "users/omniauth_callbacks" }

  # resource :users, only: [:show] do
  #   resources :lists
  # end

  root to: 'welcome#index'
end
