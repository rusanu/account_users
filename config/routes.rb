AccountUsers::Engine.routes.draw do

  get 'logout', to: 'logins#destroy', as: 'logout'

  resource 'login', only: [:show, :create, :destroy] do
    resource 'request_reset', only: [:show, :create]
  end

  resource "signup", only: [:show, :create]
  resources "validation_token", only: [:show, :update]

end

