Site::Application.routes.draw do

  devise_for :admins

  devise_for :users

  resources :evaluations

  resources :answers do
    collection do
      get 'featured'
    end
  end

  resources :questions

  resources :users do
    collection do
      get 'post'
    end
    member do
    end
  end
  
  match "users" => "users#index", :via => :get
  match ":username" => "users#post", :as => :user_post, :via => :get


  root :to => "answers#index"

end
