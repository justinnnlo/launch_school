require "socket"                                  # A gem? => NO, a library => Is it the same?

server = TCPServer.new("localhost", 3003)         # Creates a TCPServer object (ie, a TCP/IP server socket) and passes: host, port
loop do
  client = server.accept                          # Accepts an incoming connection and returns a new TCPSocket object — WAITS until someone tries to request something from the server

  request_line = client.gets                      # Read lines from socket?
  next if !request_line || request_line.match(/favicon/)
  puts request_line                               # Prints lines read from socket? => in Terminal

  client.puts "HTTP/1.1 200 OK"                   # HTTP response sent from the server to the browser
  client.puts "Content-Type: text/plain\r\n\r\n"  # HTTP response header

  method, path_and_param, protocol = request_line.split
  path, params = path_and_param.split("?")
  param_hash = {}

  for i in params.split("&")
    name, value = i.split("=")
    param_hash[name] = value.to_i
  end


  client.puts request_line                        # CLIENT prints request_line (ie, lines read from socket)

  param_hash["rolls"].times { client.puts rand(1..param_hash["sides"]) } # Prints in browser a random number between 1-6

  client.close                                    # Closes socket
end

=begin

Understanding

- Host is localhost
- Port is 3003
- The GET request is initiated by the URL in the browser
- The GET request uses the URL's path
- request_line is the full HTTP GET request
- Given line 13 prints the request line, the browser prints the HTTP request
- Lines 13 and 14 are part of the HTTP response body

Anomalies

- If line 10 isn't sent to the client it's as if the HTTP didn't have a status code — so doesn't display the response
- If line 10 changes to client.puts "HTTP/1.1 200 OK\r\n\r\n" line 11 is printed by the browser (ie, not treated as HTTP header)
- Why is it necessary to close the socket?
- In line 12, why is \r\n\r\n necessary for the HTTP header to be read by the browser?
=end