require 'sinatra'

get '/' do
  "Try POSTing to /register_kitten"
end

post '/register_kitten' do
  sleep(rand((0.1)..(0.5)))
  "Registered kitten"
end
