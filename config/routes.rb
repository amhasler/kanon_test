KanonTest::Application.routes.draw do
  get "tags/index"

  get "artobjects/tags" => "artobjects#tags", :as => :tags

  resources :users do
    member do
      get 'artobjects'
      get 'collections'
      get 'stories'
    end
  end
  resources :sessions, only: [:new, :create, :destroy]

  resources :artobjects do
    member do
      get 'users'
      get 'collections'
      get 'stories'
    end
  end
  
  resources :favorites, only: [:create, :destroy]

  root  'static_pages#home'
  match '/signup',  to: 'users#new',            via: 'get'
  match '/login',  to: 'sessions#new',         via: 'get'
  match '/signout', to: 'sessions#destroy',     via: 'delete'
 
  get 'artobjects/search'

  #===== API routes =====
  scope '/api' do
    resources :collections, only: [:show, :index, :create, :update, :destroy]

    resources :items, only: [:create, :update, :destroy, :index]

    resources :artobjects, only: [:index, :show, :create, :update, :destroy]
  end
  
end
