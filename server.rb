require 'sinatra'
require 'rabl'
require './app/clients/fiap_agent'
require './app/serializers/boletim_serializer'

configure do
  set :server, :puma
  set :views, "#{settings.root}/app/views"
end

Rabl.register!

error InvalidFIAPCredentials do
  status 401
  "Nenhum usuário encontrado"
end

post '/notas' do
  @boletim = BoletimSerializer.(FIAPAgent.new(params["rm"], params["senha"]).boletim)
  rabl :notas, format: "json"
end