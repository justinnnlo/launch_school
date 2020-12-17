# Making HTTP requests

## With a browser

Just enter the URL in the address bar and the server that hosts the URL will respond. The browser will process the response and display the resources.

## With an HTTP tool

Tools like Paw allow us to see the data sent by an HTTP response. A raw HTTP response includes more than just HTML. However, the browser's smart enough to parse and use the response in a user-friendly way.

Within the browser inspector we can check the browser's HTTP communication through the network tab. Each entry is a separate HTTP request. Why are there so many requests?

What's happening is that the browser makes one request for each resource — be it an image, file, etc. So while the resource that we typically request returns an HTML file that HTML body references other resources that the browser fetches. Thus, the browser makes a request for each additional resource referenced in the initial response. The Network tab in the browser allows you to see all referenced resources.

In contrast, a pure HTTP tool returns a single response chink without pulling referenced resources. We can confirm this through a `curl` request.

```
$ curl -X GET "https://www.reddit.com/" -m 30 -v
```

# HTTP Request Method

This is the information displayed in the `Method` column in the browser network tab. This tells the server what action to perform on the resource. The most common are:

- `GET`: retrieve information from the server
- `POST`: initiate some action on the server or send data to the server

An HTTP almost request always receives a response — even if the response is an error. It doesn't receive a response when the request times out, which is rare.

## GET Requests

`GET` requests are initiated by clicking at a link or via the browser address bar. We can also view the output of a raw HTTP response by making a GET request from the command line or HTTP tool.

We can also send query strings with an HTTP tool, such as:
```
https://itunes.apple.com/search?term=Michael%20Jackson
# Query string parameter term=Michael%20Jackson
# Remember %20 is the URL-encoded character for a space
```

A `GET` request header looks like:

```
:method: GET

:scheme: https

:authority: www.reddit.com

:path: /
Cookie: session_tracker=frindaporqeoifikcj.0.1607000949436.Z0FBQUFBQmZ5T04xWDJVQS0wS2J1cFJBRWEtZnh1VjgtblBEbkpWb1FETzBSb2Z6elFYVFVCR0JQRFZHbUhhMFI4N0tKOXBXUWdJSWhTeExVVzZuVHExcmd2dHFsNE8zczEzYXpnUUlaaUlrQVotVVR3cm9WUDhJdVE3aldWTkE2VWtkUmxXbmJqcUk; session=ef012ffb4103b72b3a8277882b0f02d43de4e845gASVSQAAAAAAAABKdePIX0dB1/I43XrZDX2UjAdfY3NyZnRflIwoNjFiOTdkMmQzMDVjYWMxMDVlNjk0MzQxY2VjMTQ3MWYxNjI3Y2RkYpRzh5Qu; __aaxsc=2; aasd=1%7C1607000946865; token_v2=eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJleHAiOjE2MDcwMDQ0MjIsInN1YiI6Ii1OVDhDODg3aGNOSy1EZkljekFBWlZZVm5xWEEiLCJsb2dnZWRJbiI6ZmFsc2UsInNjb3BlcyI6WyIqIiwiZW1haWwiXX0.RW0QOtK80Jr9PDUGcaiaJHedvXIfSX5MuKZHn0GHPMY; __gads=ID=74abcc909d71cd88-223312a646b9001d:T=1606343758:RT=1606499768:S=ALNI_MbkC96fDmlKhYoXsNDeySrfiQ7Gjg; recent_srs=t5_2thqg%2Ct5_2qhjn%2Ct5_2sdpm%2Ct5_2r7yd%2Ct5_2saqe%2C; d2_token=3.8d49a5e16a06305cc632c3976438420171c532b243b2d4f1c808625687bcedbf.eyJhY2Nlc3NUb2tlbiI6Ii1qekl5UGxSVy1PZy1yMHNhbEdEdWwzT1EyZXciLCJleHBpcmVzIjoiMjAyMC0xMC0yNVQxMzoyNjo1NS4wMDBaIiwibG9nZ2VkT3V0Ijp0cnVlLCJzY29wZXMiOlsiKiIsImVtYWlsIl19; reddaid=46ULXXF22XV4JEYB; loid=00000000007rs35c2p.2.1597850452199.Z0FBQUFBQmZjNDVwdHJvUWx3QmpKQTh0UnpPdTV1bEZaSjlpcEZMNXNac1A3MEdiMDBZLVhwQmFqSDV3aGhyR1lKY0VlZGNtR2phanNldHdZd0g3Qk55OXVfd2xTYk52emlJZUM1cVlWbmdUYmdqQlUwQTN5Y2NYTG5OMDJrM3NPZGpwYThfalVNZGk; eu_cookie_v2=3; csv=1; edgebucket=sQQSEtnD5QkWKhgzsF

Accept: text/html,application/xhtml+xml,application/xml;q=0.9,*/*;q=0.8

Host: www.reddit.com

User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_6) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/14.0.1 Safari/605.1.15

Accept-Language: en-gb

Accept-Encoding: gzip, deflate, br

Connection: keep-alive
```

And a `GET` response looks like:
```
:status: 200

Content-Type: text/html; charset=utf-8

Set-Cookie: session_tracker=frindaporqeoifikcj.0.1607001007916.Z0FBQUFBQmZ5T092VHh5U1d3VUhKN2FQZko5Mlc1eVN0bmhiVHpLNmFxWGdnbDYyLW9qUmlXcEFDX1Z3eG5iVmE3Ql9FbjFRRml5UmpOckprS0R0bUFFNTlXUkRNUzJWazRmSlNneUZfcnpzN1pqVnFSaThuei10a3pJRGQwVTFkQmtrV3lkdDJrQWs; path=/; domain=.reddit.com; secure; SameSite=None; Secure

Via: 1.1 varnish

Date: Thu, 03 Dec 2020 13:10:09 GMT

X-Frame-Options: SAMEORIGIN

Content-Encoding: gzip

Accept-Ranges: bytes

Cache-Control: private, s-maxage=0, max-age=0, must-revalidate, no-store

Vary: Accept-Encoding

Server: snooserv

Strict-Transport-Security: max-age=15552000; includeSubDomains; preload
```

To recap:
- Most links are GET requests
- We use GET requests to retrieve resources
- We can use query strings with GET requests
- If the server responds with an HTML file the browser will automatically request the other files it references — a pure HTTP tool will not

## POST requests

We can do a POST request from the command line

```
$ curl -X POST "https://echo.epa.gov" -m 30 -v
# POST request to https://echo.epa.gov
# Returns the server's response
```

A POST requests allows us to:
- Send much larger data to the server
  - No size limitations, unlike GET requests
- Send more sensitive data
  - Data is not exposed in the URL
  - Alternative: GET request would send it through query strings and expose the credentials in the URL

Within a browser, you typically use a POST request when submitting a form.

POST requests can send data in the HTTP body. The body can contain HTML, images, audio and more.

The browser hides much of the HTTP request/response cycle. For example, in the blackjack game:
1. The browser initiated an HTTP POST request
2. The server replied with an HTTP POST response
  - In the response's header, it placed in `Location` where the browser should go next
3. The browser initiates a new HTTP request to the URL in the `Location` response header

# HTTP headers

HTTP headers allow both client and server to send more information in a request/response cycle. Headers are colon-separated name/value pairs sent in plain text. We can see the headers of an HTTP request/response cycle in the network tab of the browser

## Request headers

Some ueful headers include:

|Field name|Description|Example
|-|-|-|
|Host|Server's domain name|Host: launchschool.com|
|Accept-language| List of acceptable languages|Accept-Language: en-US|
|User-Agent|Client's string identifier|User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_6) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/14.0.1 Safari/605.1.15|
|Connection|Client's preferred connection type|Connection: keep-alive|