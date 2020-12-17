#!/usr/local/bin/bash

# function server () {
#   while true
#   do
#     message_arr=()              # Aiign message_arr to an array
#     check=true
#     while $check
#     do
#       read line                 # Read an input line, as line 19
#       message_arr+=($line)      # Add each part of the line as a separate element (e.g. method is 0, path is 1, etc)
#       if [[ "${#line}" -eq 1 ]] # Final line has a length of 1, so if line length = 1 break the loop; ${#VAR} returns the parameter VAR's length
#       then
#         check=false
#       fi
#     done
#     method=${message_arr[0]}
#     path=${message_arr[1]}
#     if [[ $method = 'GET' ]]
#     then
#       if [[ -f "./www/$path" ]]
#       then
#         echo -ne "HTTP/1.1 200 OK\r\nContent-Type: text/html; charset=utf-8\r\nContent-Length: $(wc -c <'./www/'$path)\r\n\r\n"; cat "./www/$path"
#       else
#         echo -ne 'HTTP/1.1 404 Not Found\r\nContent-Length: 0\r\n\r\n'
#       fi
#     else
#       echo -ne 'HTTP/1.1 400 Bad Request\r\nContent-Length: 0\r\n\r\n'
#     fi
#     #read method path version    #message=$1 thinks nothing is an input, so it loops non-stop and you can't input anything
#     # if [[ $method = GET ]]      # Why doesn't -eq work like = ? Wasn't -eq checking for equality?
#     # then
#     #   if [[ -f ./www$path ]]    # If using e, GET / returns status code 200 when it shouldn't bc it's a directory!
#     #   then
#     #     echo -e "HTTP/1.1 200 OK\r\nContent-Type: text/html; charset=utf-8\r\nContent-Length: $(wc -c <' ./www'$path)\r\n"; cat ./www$path; echo
#     #   else
#     #     echo -e "HTTP/1.1 404 Not Found\r\nContent-Length: 0\r\n"
#     #   fi
#     # else
#     #   echo -e "HTTP/1.1 400 Bad Request\r\nContent-Length: 0\r\n"
#     # fi
#   done
# }

function server () {
  while true
  do
    my_arr=()
    check=true
    while $check
    do
      read line
      my_arr+=($line)
      if [[ "${#line}" -eq 1 ]]
      then
        check=false
      fi
    done
    method=${my_arr[0]}
    path=${my_arr[1]}
    if [[ $method = 'GET' ]]
    then
      if [[ -f "./www/$path" ]]
      then
        echo -ne "HTTP/1.1 200 OK\r\nContent-Type: text/html; charset=utf-8\r\nContent-Length: $(wc -c <'./www/'$path)\r\n\r\n"; cat "./www/$path"
      else
        echo -ne 'HTTP/1.1 404 Not Found\r\nContent-Length: 0\r\n\r\n'
      fi
    else
      echo -ne 'HTTP/1.1 400 Bad Request\r\nContent-Length: 0\r\n\r\n'
    fi
  done
}

coproc SERVER_PROCESS { server; }

nc -lv 2345 <&${SERVER_PROCESS[0]} >&${SERVER_PROCESS[1]}