Supplierx::Engine.routes.draw do
  
  resources :suppliers

  root :to => 'suppliers#index'
end
