KanonTest::Application.routes.draw do
  get "artobjects/tags" => "artobjects#tags", :as => :tags

  resources :users
  resources :sessions, only: [:new, :create, :destroy]
  resources :artobjects, only: [:create, :destroy, :index, :update]

  root  'static_pages#home'
  match '/signup',  to: 'users#new',            via: 'get'
  match '/signin',  to: 'sessions#new',         via: 'get'
  match '/signout', to: 'sessions#destroy',     via: 'delete'
  match '/about',   to: 'static_pages#about',   via: 'get'
  match '/contact', to: 'static_pages#contact', via: 'get'

  get 'artobjects/search'
  
end
