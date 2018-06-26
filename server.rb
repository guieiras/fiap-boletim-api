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
  data = JSON.parse(request.body.read.to_s) rescue {}
  rm = params["rm"] || data["rm"]
  password = params["senha"] || data["senha"]

  @boletim = BoletimSerializer.(FIAPAgent.new(rm, password).boletim)
  rabl :notas, format: "json"
end