AccountUsers::Engine.routes.draw do

  get 'logout', to: 'logins#destroy', as: 'logout'

  resource 'login', only: [:show, :create, :destroy], protocol: 'https' do
    resource 'request_reset', only: [:show, :create], protocol: 'https'
  end

  resource "signup", only: [:show, :create], protocol: 'https'
  resources "validation_token", only: [:show, :update], protocol: 'https'

end

