Rails.application.routes.draw do
 
  mount Authentify::Engine => "/authentify", :as => :authentify
  mount Commonx::Engine => "/commonx"
  mount Supplierx::Engine => "/supplierx"
  #mount Kustomerx::Engine => '/kustomerx'
  
  resource :session
  
  root :to => "authentify::sessions#new"
  match '/signin',  :to => 'authentify::sessions#new'
  match '/signout', :to => 'authentify::sessions#destroy'
  match '/user_menus', :to => 'user_menus#index'
  match '/view_handler', :to => 'authentify::application#view_handler'
end
