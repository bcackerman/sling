Bags::Application.routes.draw do

  resources :products do
    collection do
    end
    member do
    end
  end
  
  root :to => "products#main"

end
