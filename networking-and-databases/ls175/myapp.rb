# myapp.rb
require 'sinatra'

get '/' do
  'Hello world!'

  "What do you think is my name?"
  name = "Jose"

  "My name is: #{name}!"
end