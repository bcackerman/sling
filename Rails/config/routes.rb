Sling::Application.routes.draw do
  get "api/create"

  resources :clips, only: [:create]
  match "/c/:shortlink" => "clips#show", as: :show_clip

  match "/dashboard" => "dashboard#index", as: :dashboard
  
  root :to => "home#index"
  match "/about" => "home#about", as: :about
  match "/contact" => "home#contact", as: :contact

  
  
  devise_for :users

  devise_scope :user do
    resources :users
  end
end
