AccountUsers::Engine.routes.draw do

  resource 'login', only: [:show, :create, :destroy] do
    resource 'request_reset', only: [:show, :create]
  end

  resource "signup", only: [:show, :create]

  resources "validation_token", only: [:show, :update]

end

