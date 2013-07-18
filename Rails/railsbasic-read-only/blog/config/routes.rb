Blog::Application.routes.draw do

  resources :evaluations

  resources :answers

  resources :questions

  root :to => "answers#index"

  devise_for :admins
  devise_for :users

  resources :feedbacks
  resources :friendships

  resources :posts do
    collection do
      get 'topic'
      post 'played'
    end
    member do
      get 'reply'
      get 'remove'
    end
  end

  resources :gnews do
    collection do
      get 'top'
      get 'manage'
      post 'played'
    end
    member do
      get 'reply'
      get 'publish'
      get 'remove'
    end
  end

  resources :users do
    collection do
      get 'post'
    end
    member do
    end
  end
  
  match "users" => "users#index", :via => :get
  match ":username" => "users#post", :as => :user_post_profile, :via => :get
  match ":username/edit" => "users#edit", :as => :edit_user_profile, :via => :get
  match ":username" => "users#update", :as => :update_user_profile, :via => :put
  match ":username/friend" => "users#friend", :as => :user_friends_profile, :via => :get
  match "topics/:id" => "posts#topic", :as => :topic_show, :via => :get

end
