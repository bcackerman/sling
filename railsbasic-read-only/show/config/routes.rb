Show::Application.routes.draw do

  root :to => "posts#home"

  devise_for :users

  resources :users do
    collection do
      get 'avatar'
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
      post 'worker'
      post 'save'
    end
    member do
    end
  end

  resources :groups


  match ":username" => "posts#channel", :as => :post_channel, :via => :get

end
