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
  match '/about',   to: 'static_pages#about',   via: 'get'
  match '/contact', to: 'static_pages#contact', via: 'get'
 
  get 'artobjects/search'
  
end
