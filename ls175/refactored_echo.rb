require "socket"

server = TCPServer.new("localhost", 3003)

def parse_parameters(request_line)
  params = request_line.split[1].split("?")[1]
  param_hash = {}

  params.split("&").each do |i|
    name, value = i.split("=")
    param_hash[name] = value.to_i
  end

  param_hash
end

def display_response(client, request_line, param_hash)
  #client.puts request_line
  param_hash["rolls"].times { client.puts "The number is #{rand(1..param_hash["sides"])}<br>" }
  client.puts "<a href='?rolls=#{param_hash["rolls"]}&sides=#{param_hash["sides"]}'>Roll again with #{param_hash["rolls"]} rolls and #{param_hash["sides"]} sides</a><br>"
  client.puts "<a href='?rolls=#{param_hash["rolls"]-1}&sides=#{param_hash["sides"]}'>Roll with #{param_hash["rolls"]-1} rolls</a> or <a href='?rolls=#{param_hash["rolls"]+1}&sides=#{param_hash["sides"]}'>Roll with #{param_hash["rolls"]+1} rolls</a><br>"
  client.puts "<a href='?rolls=#{param_hash["rolls"]}&sides=#{param_hash["sides"]-1}'>Roll with #{param_hash["sides"]-1} sides</a> or <a href='?rolls=#{param_hash["rolls"]}&sides=#{param_hash["sides"]+1}'>Roll with #{param_hash["sides"]+1} sides</a>"
end

loop do
  client = server.accept

  request_line = client.gets
  next if !request_line || request_line.match(/favicon/)
  puts request_line

  param_hash = parse_parameters(request_line)

  client.puts "HTTP/1.1 200 OK"
  client.puts "Content-Type: text/html\r\n\r\n"

  client.puts "<html>"
  client.puts "<body>"
  display_response(client, request_line, param_hash)
  client.puts "</body>"
  client.puts "</html>"

  client.close
end
