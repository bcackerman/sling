Quid::Application.routes.draw do
  root :to => "home#index"
  match "/about" => "home#about", as: :about
  match "/contact" => "home#contact", as: :contact

  devise_for :users

  devise_scope :user do
    resources :users
  end
end
