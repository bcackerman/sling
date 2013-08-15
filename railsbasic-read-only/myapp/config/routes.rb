Myapp::Application.routes.draw do

  resources :friendships
  resources :posts
  devise_for :admins
  devise_for :users

  root :to => "posts#index"

  match "users" => "users#index"
  match ":username" => "users#show", :as => :show_user_profile, :via => :get
  match ":username/edit" => "users#edit", :as => :edit_user_profile
  match ":username" => "users#update", :as => :update_user_profile, :via => :put
  match ":username/friend" => "users#friend", :as => :user_friends_profile

  match "posts" => "posts#index"
  match "posts/:id/reply" => "posts#reply", :as => :reply_post
  match "topics/:id" => "posts#topic", :as => :topic_show

end
