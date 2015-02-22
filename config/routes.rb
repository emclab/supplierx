Supplierx::Engine.routes.draw do
  
  resources :suppliers do
    collection do
      get :search
      get :search_results
      get :autocomplete
    end
  end

  root :to => 'suppliers#index'
end
