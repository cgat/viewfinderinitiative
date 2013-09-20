Viewfinderinitiative::Application.routes.draw do
  authenticated :user do
    root :to => 'home#index'
  end
  devise_scope :user do
    root :to => 'landing#index' #"devise/registrations#new"
    match '/user/confirmation' => 'confirmations#update', :via => :put, :as => :update_user_confirmation
  end
  devise_for :users, :controllers => { :registrations => "registrations", :confirmations => "confirmations" }
  match 'users/bulk_invite/:quantity' => 'users#bulk_invite', :via => :get, :as => :bulk_invite
  resources :users do
    get 'invite', :on => :member
    resources :user_repeat_images
  end

  resources :user_repeat_images, except: [:new] do
    resources :alignment, controller: 'alignment'
  end
  #when creating a new user_repeat_image, use this route, as a repeat_pair_id is required for creation.
  get 'repeat_pair/:repeat_pair_id/user_repeat_images/new' => 'user_repeat_images#new', as: 'new_repeat_pair_user_repeat_image'

  resources :repeat_images
  resources :historic_images
  resources :stations
  resources :alignment

end
