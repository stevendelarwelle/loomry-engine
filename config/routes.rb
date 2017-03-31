Rails.application.routes.draw do

  
  # Added by Koudoku.
  mount Koudoku::Engine, at: 'koudoku'
  scope module: 'koudoku' do
    get 'pricing' => 'subscriptions#index', as: 'pricing'
  end


  get 'dashboard/index'

  resources :licenses
  resources :softwares
  devise_for :users
  root to: "pages#home"
  get 'pages/about'
  
  # namespace :api do 
  #   namespace :v1 do 
  #   	resources :softwares
  #   	resources :licenses
  #   end 
  # end
  
  namespace :api do
    namespace :v1 do
      #resources :softwares, only: [:confirm]
      get 'licenses/confirm' => 'licenses#confirm'
      #post 'licenses/new' => 'licenses#create'
      resources :licenses, only: [:show, :create]
      
    end
  end
end
