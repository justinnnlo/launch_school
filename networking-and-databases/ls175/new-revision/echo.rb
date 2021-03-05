require "socket"

server = TCPServer.new('localhost', 3003)

loop do
  client = server.accept

  request_line = client.gets
  puts request_line
  puts "Is this working?"

  client.puts request_line
  client.close
end