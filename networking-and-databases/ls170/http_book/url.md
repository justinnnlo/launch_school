A URL is a **Uniform Resource Identifier**, which separates how resources are located. A URL is based on 5 components:
- Scheme (`http`)
  - Where: It comes before the colon and 2 forward slashes
  - Why: It tells the web client how to access the resource — in this case through the HTTP
  - Alternatives: other schemes include `ftp`, `mailto` or `git`
  - It's sometimes also (imprecisely) referred as the protocol because the scheme indicates what protocol should be used to access the resource
- Host (`www.google.com`): it tells the client where the resource is located or hosted
- Port (`:88`): only required when you use a port [rather than the default host?]
- Path (`/home/`): the local resource being requested — this is optional
  - Note: may sometimes point to a specific resource (e.g. `/index.html` points to an HTML file in the server)
- Query string (`?item=book`)
  - What: conformed of query parameters
  - Why: send data to the server

A simple URL with a query string might look like
```
http://www.example.com?search=ruby&results=10
```

- Scheme: `http`
- Host: `www.example.com`
- Port: none
- Path: none
- Query string: `?search=ruby&results=10`

The query string itself can be broken down into:
- `?`: a reserved chatacter that tells when a query string will start
- `search=ruby`: a parameter name/value pair
- `&`: reserved character to add more parameters to the query string
- `result=10`: another parameter name/value pair

Second try:
```
http://www.phoneshop.com?product=iphone&size=32gb&color=white
```
- Scheme: `http`
- Host: `www.phoneshop.com`
- Port: none
- Path: none
- Query string: `?product=iphone&size=32gb&color=white`
  - `?`: reserved keyword marking start of query string
  - `product=iphone`, `size=32gb`, `color=white`: name/value pairs
    - Parameter names: `produce`, `size` and `color`
    - Parameter values: `iphone`, `32gb` and `white`
  - `&`: reserved keyword marking concatenation of name/value pairs

Query string are only used in HTTP GET requests because they're passed in through the URL. Besides URLs in the address bar, most links also issue HTTP GET requests. Query strings can pass additional information to the server but are limited by:
- A maximum length
- Name/value pairs are visible in the URL — so you shouldn't pass sensitive information like usernames and passwords
- Spaces and special characters like `&` cannot be used with query strings and must be URL encoded

# URL Encoding

URLs are deisgned to accept only certain characters from the standard 128 ASCII-character set. We have to encode i) reserved or unsafe ASCII characters and ii) characters not in this set. URL encoding replaces those non-conforming characters with a `%` symbol followed by two hexadecimals representing the character.

|Character|ASCII code|URL|
|---------|----------|---|
|Space    |20        |http://www.thedesignshop.com/shops/tommy%20hilfiger.html|
|!	      |21	       |http://www.thedesignshop.com/moredesigns%21.html|
|+	      |2B	       |http://www.thedesignshop.com/shops/spencer%2B.html|
|#	      |23	       |http://www.thedesignshop.com/%23somequotes%23.html|

Reserved ASCII characters include:
- `/`
- `?` to delimit the start of the query string
- `:` to delimit host/port components and user/password
- `@`
- `&` to delimiter query strings

Unsafe ASCII characters include:
- `%` because it's used to encode other characters
- ` `
- `"` or `'`
- `#`
- `<` and `>`
- `{` and `}`
- `[` and `]`
- `~`

Inversely, safe characters that can be used unencoded are:
- Alphaneumeric characters
- The special characters `$-_.+!'()",`
- Reserved characters when used for their reserved properties
  - But when they aren't used for their reserved purpose they need to be encoded