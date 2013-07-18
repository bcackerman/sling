Shake::Application.routes.draw do

  resources :users

  resources :drinks

  resources :pubs

  resources :products do
    collection do
    end
    member do
    end
  end
  
  root :to => "products#index"

end
