Rails.application.routes.draw do
  #resources :list_items
  resources :lists
  resources :dishes, except: [:edit, :update, :destroy]

  resources :restaurants, except: [:edit, :update, :destroy] do
    resources :dishes, only: [:show, :index, :new, :create]
  end

  devise_for :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  root to: 'welcome#index'
end
