require 'sinatra'

get '/' do
  "Try POSTing to /register_kitten"
end

post '/register_kitten' do
  sleep(rand((0.05)..(0.3)))
  "Registered kitten"
end
