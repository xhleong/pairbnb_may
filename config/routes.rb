Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root 'home#index'

  resources :passwords, controller: "clearance/passwords", only: [:create, :new]
  resource :session, controller: "clearance/sessions", only: [:create]

  resources :users, only: [:create] do
    resource :password, controller: "clearance/passwords", only: [:create, :edit, :update]
  end

  # get 'listings/new' => 'listings#new', as: 'new_listing'

  resources :listings

  patch 'listings/:id/verify' => "listings#verify", as: 'verify'

  #localhost:3000/auth/google_oauth2/callback
  get "/auth/:provider/callback" => "sessions#create_from_omniauth"
end
