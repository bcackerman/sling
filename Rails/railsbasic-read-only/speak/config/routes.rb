Show::Application.routes.draw do

  root :to => "posts#home"

  devise_for :users

  resources :users do
    collection do
      get 'avatar'
      post 'save'
    end
    member do
    end
  end

  resources :posts do
    collection do
      get 'featured'
      get 'channel'
      get 'player'
      get 'upload'
      post 'save'
      post 'view'
    end
    member do
    end
  end

  resources :questions do
    collection do
      get 'select'
      get 'channel'
    end
    member do
    end
  end

  resources :groups do
    collection do
      get 'channel'
    end
    member do
    end
  end

  resources :speeches do
    collection do
      post 'view'
    end
    member do
    end
  end

  resources :quotes

  resources :likes

  resources :ratings do
    collection do
      get 'metric'
    end
    member do
    end
  end

  resources :feedbacks


  match ":username/posts" => "posts#channel", :as => :post_channel, :via => :get
  match ":username/questions" => "questions#channel", :as => :question_channel, :via => :get
  match ":username/groups" => "groups#channel", :as => :group_channel, :via => :get

  match "featured/:id", :to => "speeches#show", :as => :featured, :via => :get

end
