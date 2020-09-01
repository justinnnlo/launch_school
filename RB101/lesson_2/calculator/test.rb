require 'yaml'

puts yml = YAML.load_file("test.yml")
puts "#{yml[name]} is great!"