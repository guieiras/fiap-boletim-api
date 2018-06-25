require 'sinatra'

configure { set :server, :puma }

post '/notas' do
  "Hello World!"
end