Rails.application.routes.draw do
 
  mount Supplierx::Engine => "/supplierx"
  mount Authentify::Engine => "/authentify"
  mount Commonx::Engine => "/commonx"
  mount Searchx::Engine => '/search'
  #mount Kustomerx::Engine => '/kustomerx'
  
  root :to => "sessions#new", module: :authentify
  get '/signin',  :to => 'sessions#new', module: :authentify
  get '/signout', :to => 'sessions#destroy', module: :authentify
  get '/user_menus', :to => 'user_menus#index', module: :main_app
  #match '/authentify/view_handler', :to => 'application#view_handler', module: 'authentify', via: [:get, :post]
  get '/view_handler', :to => 'application#view_handler', controller: 'application'
end
