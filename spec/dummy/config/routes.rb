Rails.application.routes.draw do
 
  mount Authentify::Engine => "/authentify", :as => :authentify
  mount Commonx::Engine => "/commonx"
  mount Supplierx::Engine => "/supplierx"
  #mount Kustomerx::Engine => '/kustomerx'
  
  root :to => "sessions#new", controller: :authentify
  get '/signin',  :to => 'sessions#new', controller: :authentify
  get '/signout', :to => 'sessions#destroy', controller: :authentify
  get '/user_menus', :to => 'user_menus#index', controller: :main_app
  get '/view_handler', :to => 'application#view_handler', controller: :authentify
end
