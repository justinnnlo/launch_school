require 'yaml'

name = "Jose"
TEST = YAML.load("Hi, #{name}!")
puts  TEST