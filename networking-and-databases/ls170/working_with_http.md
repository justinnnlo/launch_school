# Netcat to connect with a remote server and send an HTTP request

`netcat` is a network utility. One of the features it provides ia creating a TCP connection between 2 network end-points.

Why: this shows HTTP is a text-based protocol moving between the server and client.

The header metadata of the response that doesn't go on the response body itself

A response can have any number of headers and have a wide variety of values.

```
nc -v google.com 80 # Server: google.com; Port: 80 (because it's a web server)
Connection to google.com port 80 [tcp/http] succeeded!
GET /                                       # GET request to gome page

                                            # Start of header
HTTP/1.0 200 OK                             # Status code and HTTP version used
Date: Fri, 04 Dec 2020 10:04:04 GMT         # Date the reqyest was created at
Expires: -1
Cache-Control: private, max-age=0
Content-Type: text/html; charset=ISO-8859-1 # Type of content
P3P: CP="This is not a P3P policy! See g.co/p3phelp for more info."
Server: gws
X-XSS-Protection: 0
X-Frame-Options: SAMEORIGIN
Set-Cookie: NID=204=JW7cTQO0k1OG2U1pYqSTPsF10Y2p1oPNcVQIFkD3MSyJg9G7J0FnASLD0WL4viki9Do7rTvZ8yxiQTlXgFArJ8iYe7e4iMjrnb-hB6_lMzXsClTCUkpeUTpluwrltCcRAVZIRlsPlRNgNnkfBlOiiByEPx4veEk-lgWaHkwJlPA; expires=Sat, 05-Jun-2021 10:04:04 GMT; path=/; domain=.google.com; HttpOnly
Accept-Ranges: none
Vary: Accept-Encoding

                                              # Start of body
[Body continues below...]
```

Note that the `-v` flag means "verbose". This tells `netcat` to print messages when certain things happen, like a connection opening or closing.

Google's server interpreted the HTTP request because it followed syntactical rules that the server was familiar with. But HTTP syntax changes with every version. The `GET /` request we sent follows the HTTP 0.9 syntactical rules which only require a method and path in the request line. Google's server supports this syntax despite responding with HTTP 1.0 (HTTP 0.9 doesn't include headers)

What happens if they communicate in syntax that's unfamiliar to one or the other? In the example below, I make a request using the same `GET /` HTTP 0.9 syntax to a server that doesn't understand it.

```
nc -vc launchschool.com 80
Connection to launchschool.com port 80 [tcp/http] succeeded!
GET /
HTTP/1.1 400 Bad Request
Connection: close
Server: Cowboy
Date: Fri, 04 Dec 2020 10:15:12 GMT
Content-Length: 0
```

It's status code is `400` — and a `4XX` error code indicates a client-side error. `400` specifically says that there's an error in the request's structure — the server didn't understand the request's syntax.

Versions subsequent to HTTP 0.9 require that we append the HTTP version, such as `GET / HTTP/0.9`:
```
nc -vc launchschool.com 80
Connection to launchschool.com port 80 [tcp/http] succeeded!
GET / HTTP/0.9
HTTP/1.1 505 HTTP Version Not Supported
Connection: close
Server: Cowboy
Date: Fri, 04 Dec 2020 10:21:26 GMT
Content-Length: 0
```

We now get a different status code — `505`. `5XX` error codes indicate a server-side error. So the server understood the message, but it responded by saying it doesn't support that HTTP version.

We can send the same message with another version:
```
nc -vc launchschool.com 80
Connection to launchschool.com port 80 [tcp/http] succeeded!
GET / HTTP/1.1

HTTP/1.1 400 Bad Request
Connection: close
Server: Cowboy
Date: Fri, 04 Dec 2020 10:26:56 GMT
Content-Length: 0
```

Here we get another `400` status code because we made a bas request on the client side. This is because we need to send the request with the host.

```
nc -vc launchschool.com 80
Connection to launchschool.com port 80 [tcp/http] succeeded!
GET / HTTP/1.1
Host: launchschool.com

HTTP/1.1 301 Moved Permanently
Connection: keep-alive
Server: nginx
Date: Fri, 04 Dec 2020 10:28:13 GMT
Content-Type: text/html
Transfer-Encoding: chunked
Location: https://launchschool.com/
Via: 1.1 vegur

0
```

This response returned a `3XX` status code, which usually indicates a redirection and requires the client to do an additional action to complete the request. A browser would automatically initiate a new request and redirect to the new location. Note that the response's connection isn't automatically closed as it has a `Connection: keep-alive` header. This happens because it expects a new request, but it usually closes shortly afterwards.

# Bash basics

Bash is a command language to interact with our system environment.

## Variables

Bash uses variables to temporarily store data, as with other scripting or programming languages.

Variables are declared by naming them and assigning values with the `=` operator or with an input after using the `read` command. Variables can be in upper or lowercase, but Bash is case sensitive. When a variable has been declared, we can reference by prepending its name with `$`.

```
name="Jose"
$name       # Command not found: Jose
echo $name  # Jose
echo name="Agustin" # name=Agustin
echo $name          # Jose
read name           # Cursor moves to newline, waits for input
Jose                # Input line
echo $name          # Jose
```

If `$` isn't prepended to the variable, it'll treat it as text.
```
name="Jose"
echo name   # name
```

We can also declare multiple variables at the same time, with the last one acting like the spalt operator in Ruby:
```
# Excess values: placed in last variable
read one two three
Do you like this?
echo $one         # Do
echo $two         # you
echo $three       # like this?

# Excess variables: assigned to nothing
read test1 test2
Do?
echo $test1   # Do?
echo $test2   #
```

Remember that Bash commands are executable files — so we can create custom commands. They don't require an extension but typically use the `.sh` extension.

Bash files can be executed in 2 ways:
1. Passing the file as an argument to `bash` command: `bash [FileName]`
2. Specifying the mode of execution in the file at the top of the file
  - Code placed at top: `#!/bin/bash`
    - `#!` (shebang character sequence): telling the program to use the subsequent program to run the code
    - `/bin/bash/` (program): the program used to run the code (in this case bash)
      - Note: this should be the location of bash — you can confirm it with `which bash`
  - Making the file executable (if it isn't)
    - Change file permissions with `chmod +x [FileName]`
  - Run the file by indicating its location
    - E.g. a file in the current directory would be `./[FileName]`

## Conditional statements

`if` bash statements start with the `if` command and ends with `fi`, where `if` tests for truthiness (`true` and `false`).

```
if true
then
  echo "True"
fi
# True

if false
then
  echo "True"
fi
```

In `if [[ <condition> ]]`, the statement evaluates the truthiness of `<condition>`. The brackets are a shorthand syntax for the `test` command, which is what returns the condition's truthiness. Thus, we could also replace it with `if test <condition>`.

```
if test hi    # Evaluates to truthy
then
  echo "True"
fi
# True

if test       # Evaluates to falsey
then
  echo "True"
fi
```

The `test` command has some helpful operators for when we work with strings, integers, files or more.

### `String` test operators

|Operator|Description|
|-|-|
|-n string|Length of string is greater than 0|
|-z string|Length of string is 0 (string is an empty string)|
|string_1 = string_2|string_1 is equal to string_2|
|string_1 != string_2|string_1 is not equal to string_2|

<br>

### `Integer` test operators
|Operator|Description|
|-|-|
|integer_1 -eq integer_2|integer_1 is equal to integer_2|
|integer_1 -ne integer_2|integer_1 is not equal to integer_2|
|integer_1 -gt integer_2|integer_1 is greater than integer_2|
|integer_1 -ge integer_2|integer_1 is greater than or equal to integer_2|
|integer_1 -lt integer_2|integer_1 is less than integer_2|
|integer_1 -le integer_2|integer_1 is less than or equal to integer_2|

<br>

### `File` test operators
|Operator|Description|
|-|-|
|-e path/to/file|file exists|
|-f path/to/file|file exists and is a regular file (not a directory)|
|-d path/to/file|file exists and is a directory|

<br>

### Examples
1. Output a string if it's longer than 0
```
string=hello
if [[ -n $string ]]
then
  echo $string
fi  # hello
```

2. Output a string if 2 integers are equal
```
integer_1=20
integer_2=10
if [[ integer_1 -eq integer_2 ]]
then
  echo The numbers are equal!
fi

integer_2=20
if [[ integer_1 -eq integer_2 ]]
then
  echo $integer_1 and $integer_2 are the same!
fi  # 20 and 20 are the same!
```

Note: Variables can be placed alongside strings when passing them as arguments to a command like `echo`.
3. Output "File exists" if `hello_world.sh` exists
```
if [[ -e /Users/jadlp/repos/launch_school/ls170/bash_basics/hello_world.sh ]]
then
  echo File exists!
fi  # File exists!

if [[ -e ./hello_world.sh ]]
then
  echo File exists!
fi  # File exists!
```

### Multiple conditions

Bash has many of the functionalities found in Ruby:
- Nested `if` statements
- Multiple conditional branches with `if`, `elif` and `else`
- Match two conditions with `&&`
- Match one or more conditions with `||`
- Use `!` in a test to reverse its sense
  - Note: `!` has many different uses; for this to work correctly, place the test in a parentheses
  - E.g. `! ([[ 5 -eq 5 ]])

## Loops

Bash has the following looping constructs:
- `while`
- `for` (as in Ruby, it iterates through a list)
  - `for number in $numbers`, where `$numbers` is `number="1 2 3 4 5 6 7 8 9 10"`
- `until`

A loop is defined by `do` and `done`. A loop first defines the loop type and test, followed by `do..end`

We can also increment variables with `(($var++))` (the double parentheses permit arithmetic expansion).

## Functions

Bash functions work like Ruby methods — as containers of one or more commands as a chunk of code. As the chunk is named it can be executed later. Functions can take one or more arguments.

```
greeting () {
  echo Hello $1
}

greeting Peter        # Hello Peter
greeting Peter Paul   # Hello Peter => only takes the number of args as expected
greeting "Peter Paul" # Hello Peter Paul => Quotation treats string as one

greeting () {
  echo Hello $1
  echo Hello $2
}
greeting Peter Paul
# Hello Peter
# Hello Paul

greeting Peter
# Hello Peter
# Hello
```

# TCP communication with `nc`

We can use `nc` from the terminal to listen on a port for incoming connections.

```
nc -lv 2345

```

This terminal becomes the server-side. The newline means that we are listening on incoming communication.

On a 2nd terminal, we can set-up the client-side with:

```
nc -v localhost 2345
nc: connectx to localhost port 2345 (tcp) failed: Connection refused
Connection to localhost port 2345 [tcp/dbm] succeeded!
```

Note that on the client side we're not passing the `-l` flag — so we're running the default "client" mode (but we keep the `-v` to operate in verbose mode).

On the client side, we're also indicsting `localhost` (ie, our local machine) — which we didn't on the server side.

In these cases we've created 2 instances within 2 different terminal windows: a client and a server instance.

`Connection to localhost port 2345 [tcp/dbm] succeeded!` tells us that the TCP connection has been established between the server and client instance.

Note: it seems there can only be a single server-client connection — a 2nd client can't connect with a server that's already connected to a client.

# Implementing our HTTP server

We previously used `nc` to perform a message exchange over a TCP connection. The message exchange was arbitrary and didn't follow any syntactical rules — I'd just type something in and it's appear on the other side.

HTTP does some processesing of client messages and issues a response based on the protocol.

Within `http_server.sh` we paste in:
```
#!/bin/bash

function server () {

}

coproc SERVER_PROCESS { server; }

nc -lv 2345 <&${SERVER_PROCESS[0]} >&${SERVER_PROCESS[1]}
```

What's going on there?

`function server () { }` creates a function called `server`, where we'll put in the processing logic for the HTTP server program.

`coproc SERVER_PROCESS { server; }` is composed of 2 things: the `coproc` command and the process `SERVER_PROCESS`
- `coproc` runs server function asynchronously alongside nc/netcat
- `SERVER_PROCESS` is a process that executes the server function

The last line execute the `nc` command as a server and in verbose mode (i.e. with the options `-lv`) to listen on port `2345`. The second part redirects `STDOUT` and `STDIN`. It takes the `nc` process input and redirects it to `SERVER_PROCESS` which passess it to the input (`STDIN`) of the `server` function. The output `STDOUT` of the server function is automatically passed to `SERVER_PROCESS` and redirected to the output of `nc`.

Implication: all `nc` inputs can be accessed from `server` (thus, nothing is outputted on the server side) and any `server` function outputs using echo will be output by `nc`.