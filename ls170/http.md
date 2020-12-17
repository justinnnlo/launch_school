# What to focus on

- Understand HTTP's role
- Break things down into individual components and understand each of their purposes

# Application layer

The application layer in both the Open System Interconnection and TCP/IP models doesn't refer to the applications themselves — but to a set of protocols that provide communication services to applications.

The application mostly interacts with application layer protocols — but apps aren't restricted to communicating only with those protocols. For example, applications can interact with Transport protocols by opening TCP socket. Nonetheless, it's uncommon for apps to interact with protocols under the Transport layer.

So far we've looked at protocols and layers that dealt with how to send information. In contrast, application layer protocols focus on what is being set — on how to structure a message rather than how to send it. These protocols rely on protocols under the application layer to ensure the message gets to its correct destination.

## Conceptualizing application layer protocols

These are a set of rules for how applications should talk to each other at a syntactical level. There are many application layer protocols because there are many types of applications with different requirements. For example, an email client will need different rules than a web browser to communicate with a server — because one does so with an email and the latter with a web server.

# HTTP and the Web

The internet is a network of networks — an infrastructure that enables inter-network communication in terms of both the physical network and protocols that enable its use.

The web or WWW is a service that can be accessed by the internet — an information system that can be used through Uniform Resource Locators (URL). HTML is the primary means applications interact with the resources that make up the web.

### Web history

The WWW was created by Tim Berner-Lee in 1989 and formalized in 1990 to solve a communication problem at CERN.

CERN computers were in different cities or countries. Even though they were connected over a network the information stored in them was difficult to access. To access something in a computer you'd need to:
1. Log on to a specific computer
2. Use a program or set of commands to locate and access the information you wanted
  - Note: the programs and commands tended to vary between computers

TBL's idea was to create an information system that used both the internet and the emerging Hypertext technology to structure and connect the resources with hyperlinks. He achieved that uniformity through a combination of technologies: HTTP, HTML, URI.

- Hypertext Markup Language (HTML) uniformly structured the resources
  - The first version of HTML had only 18 elements, such as lists, paragraphs, and headings
  - The most revolutionary was the anchor tag, which used the `href` attribute to provide a link from one resource to another
- Uniform Resource Identifiers (URI): a string of characters that identifies a particular resource
  - Key idea: resources should be uniformly addressed through the web
- Hypertext Transfer Protocol (HTTP): a set of rules that standardizes how web resources are transferred between applications

# HTTP book

# Background and diagrams

## Client-Server

When we talk about HTTP request/response cycle, we thinkg about it as a single request that is sent, processed, and a single response that is returned. Thus, it's a mental model with 2 lines going in opposite directions.

But what happens within the server?

When we zoom in we find that:
1. Server have 3 components: web server, application server and database
  - Web server: a server that responds to requests for static assets
    - They don't require any data processing — so they can be handled by a simple server
  - Application server: more complicated requests are handled
    - Typically stores application or business logic
  - Data stores
    - Consulted by application servers to retrieve or create data
    - Data stores can be simple files, key/value stores, etc as long as it can save data in a formate for later retrieval and processing
2. The server, and even each component, could be comprised of multiple machines
  - Relatedly, there could be many intermediary machines like load balancers
  - Larger server infrastructures have hundreds or thousands of machines

## HTTP over TCP/IP

HTTP cycles are **usually** handled by TCP/IP connections. TCP/IP ensures that the messages structured by HTTP are handled correctly and that the cycle between the browser and server is completed.

# URLs

## URLs vs URIs

URI: means to identify a particular resource
URL: a subset of URI that also includes the network location of the resource

This overlapping is why URIs and URLs are sometimes used interchangeably. [See this video for more details](https://www.youtube.com/watch?v=if0pzXWZOfY).

## Schemes and protocols

A scheme is NOT a protocol

`https://www.launchschool.com` has the scheme `https`. That isn't the HTTPS protocol, the scheme identifies which protocol family should be used to access the resource — not a specific protocol version.

Note that the convention is for schemes to be in lowercase and protocols to be in uppercase.

## URLs and file paths

URLs have changed over time. The concept derived from a combination of domain names and Unix-style file paths. Thus, `http://www.josedelapuente.com/index.html` retrieves the resource `index.html` from the server identified by `www.josedelapuente.com`.

What's changed is that the web tends to now be dynamically generated — rather than statically. In these cases, the content is dynamically generated in the server combining templates with data to produce HTML pages that form the body of the HTTP response. This can also be slightly different with client-side frameworks, where the HTTP response contains raw data manipulated by an application running in the browser before its rendered.

The similarity of client- and server-side frameworks have when dynamically generating content is that the path of the URL is deterimned by application logic — it may not represent an underlying file structure in the server.

## URL components exercises

```
https://amazon.com/Double-Stainless-Commercial-Refrigerator/B60HON32?ie=UTF8&qid=142952676&sr=93&keywords=commercial+fridge
```

Host: `www.amazon.com` => should be `amazon.com`
Query parameter names: `ie`, `qid`, `sr`, `keywords`
Query parameter values: `UTF8`, `142952676`, `93`, `commercial+fridge`
Scheme: `https`
Path: `/Double-Stainless-Commercial-Refrigerator/B60HON32`
Port: None contained (note it has one though it isn't in the URL), though URLs with a scheme of `https` usually use by default port 443

```
http://amazon.com/products/B60HON32?qid=142952676&sr=93
http://amazon.com:3000/products/B60HON32?qid=142952676&sr=93 => added port 3000
```

```
http://localhost:4567/todos/15
```

Query parameters: None
Scheme: `http`
Path: `/todos/15`
Host: `localhost`
Port: `4567`

What are 2 different ways to encode a space in a query parameter?
- `%20`: used before query strings?
- `+`: used in query strings?
[Solution in here](https://stackoverflow.com/questions/1634271/url-encoding-the-space-character-or-20)

What character indicates the start of a query parameter?
`?`

What character is used between the name and value of a query parameter?
`=`

What character is used between multiple query parameters?
`&`, which ¿concatenates? query parameters.

# Request/Response Cycle

Domain name: used to determine what server to send it to — not part of the request itself

When a server processes a reques it:
- Verifies the user session
- Load tasks from the database
- Renders HTML

The respond contains the:
- Status codes
- Headers: metadata of the content of the response
- Body

When the response is received it displays it (if applicable). If it isn't an HTML file (e.g. an audio file) the browser would act according to what it'd usually do with that file type.

Practice problems

1. Components of an HTTP request
  - Required
    - Method
    - Path
    - Host
  - Optional
    - Query parameters
    - Message body
    - Other headers
2. Components of an HTTP response
  - Required
    - Status code
  - Optional
    - Header
    - Body
3. What determines whether a request should use `GET` or `POST` as its HTTP method?
 - `GET` requests should only retrieve a resource from the server
  - Ie, only for "read only" operations
  - Some exceptions, e.g. a webpage that tracks how many times it's viewed
    - Appropriate to use `GET` as the main content of the page doesn't change
 - `POST` requests should be used to change the a value stored in the server
  - Some forms might use `GET` if they don't change data on the server and only view it
    - Ie, this would be a "read only" operation
    - However: most HTML forms use `POST`

# EXTRA: HTTP methods

There are some general characteristic of HTTP methods that help us understand their differences at a high-level:
- Request has body
- Successful response has body
- Safe: can it modify the state/data of the server (i.e. it is a read-only operation)?
  - Note: all safe methods are idempotent but not all idempotent methods are safe
- Idempotent (idem + potent; same + power/influence): calling a method once or several times successively has the same effect
  - Technically: it has no side effect
  - Example: passing the same order several time only places a single order
- Cacheable: responses can be stored and used later, saving a new request
- Allowed in HTML forms

|Method|Request body|Succ. resp. body|Safe|Idempotent|Cacheable|HTML forms|
|-|-|-|-|-|-|-|
|GET|N|Y|Y|Y|Y|Y|
|HEAD|N|N|Y|Y|Y|N|
|POST|Y|Y|N|N|Only if freshness information is included|Y|
|PUT|Y|N|N|Y|N|N|
|DELETE|May|May|N|Y|N|N|

## Request and response anatomies

An HTTP request and response is comprised of 5 elements:
1. HTTP method
2. Path
3. Protocol version
4. Headers
5. Body (optional)

E.g.: `GET / HTTP/2.0` (`GET` method, `/` path, `HTTP/2.0` protocol and no headers or body)

A response replaces the method name and path with status code and status message:

1. Protocol version
2. Status code
3. Status message
4. Headers
5. Body (optional)

## GET

|Method|Request body|Succ. resp. body|Safe|Idempotent|Cacheable|HTML forms|
|-|-|-|-|-|-|-|
|GET|N|Y|Y|Y|Y|Y|

`GET` is an HTTP method to request a resource, which is returned in the HTTP response body (if successful). This is a safe method: it performs a read-only operation and can't alter the state of the server.

`GET` methods are thus commonly used to retrieve a web resources, such an HTML page or an image. `GET` methods are limited when it comes to passing information to the server because it doesn't have a body — hence why query strings are used in URLs.

Note that `GET` methods are tightly tied to URLs *because `GET` requests a resource through URL*. Thus, a `GET` request could be 

### HEAD

Note that `HEAD` is similar to `GET` but for 2 variations:
- `HEAD` responses don't have a body
- `HEAD` cannot be used in HTML forms

Thus, `HEAD` is appropriate when we want the response header that the response to a `GET` request would return without downloading the resource itself.

## POST

|Method|Request body|Succ. resp. body|Safe|Idempotent|Cacheable|HTML forms|
|-|-|-|-|-|-|-|
|POST|Y|Y|N|N|Only if freshness information is included|Y|

A `POST` request is commonly used to change the state/data of the server. Unlike a `GET` request, a `POST` request can:
- Send unlimited data because it sends it via its request body
- Can perform a writting operation on the server
- Has side-effects: multiple identical `POST` requests will each be performed because it isn't idempotent
- `POST` responses can be cached under limited circumstances

### PUT

`PUT` is another method that can write to the server, but has a few nuances:
- A successful response to a `PUT` request doesn't have a body
- `PUT` is idempotent while `POST` is not
- `PUT` responses can never be cached
- `PUT` cannot be used in HTML forms while `POST` can be

This explains:
- Why `POST` is used in HTML forms — because `PUT`can't be
- Why `POST` can be dangerous in ordering applications as a non-idempotent method, like e-commerce or food delivery
- Why `POST` should be used when the response should have a body

But note that the crucial difference is that `POST` is not idempotent while `PUT` is.

# EXTRA: HTTP Headers

HTTP headers contain metadata for how the request or response should be handled.

There are 4 broad type of headers:
- General: have no relation to the data being transmitted
- Request: more information of the resource being fetched or the client making the request
- Response: more information of the response, like its location or info on the server that holds it
- Entity: information about the **body** of the resource, like it's content length

Headers can also be grouped by the functionality that they provide, such as:
- Authentication
- Caching
- Connection management

# EXTRA: Mozilla's overview of HTTP

HTTP is a text-based protocol that structures communication between 2 devices so that the machines can understand the messages. HTTP clearly establishes the 2 parties exchanging messages: there's a client and a server. Unlike other layers of the network communication system, HTTP messages are exchanged individually — the client sends a message and the server replies with a response.

Note that the client is typically, but doesn't **need** to be a browser. For example, it could be a robot (which is why some pages check if you're human).

## HTTP: stateless but not sessionless

A stateless protocol does not store any information between messages. In that sense, HTTP is stateless because **the server doesn't store any information between 2 requests**.

This is addressed via sessions, which imitate an experience of statefulness. Sessions link requests with the state of the server. These cookies are passed via HTTP headers — which is how different requests can share the same context or state.

## HTTP and connections

A connection is out of scope of HTTP because it's controlled at the transport layer. Thus, before exchanging messages over HTTP both parties need to establish a TCP connection.

This implies that historically before each HTTP request/response a TCP connection had to set up, increasing latency. This has been addressed as HTTP has evolved via:
- HTTP/1.1: pipelining (sending various requests at a time) and persistent connections (partially controlling the underlying TCP connection)
  - Note: pipelining HTTP requests has been difficult because of the coexistance of old and new software versions, which is why it was superceded in HTTP/2.0 with better multiplexing
- HTTP/2.0: multiplexing messages over a single connection

Thus, while before the connection had to be closed we can now reuse a TCP connection

## HTTP and TCP

HTTP is **typically** sent over TCP or over a TLS-encrypted TCP connection, though any reliable transport protocol could theoretically be used.

[Note: does this mean that HTTP **requires** reliability? Wouldn't UDP be applicable?]

## HTTP and proxies

Between the client and the server there are many devices at different layers. The devices that operate in the application layers are called **proxies**. Proxies perform to broad type of actions:
- Transparent: forwards the request without modifying it
- Non-transparent: modifies the request before forwarding it

The type of actions a proxy can do include:
- Caching
- Filtering (e.g. antispam)
- Authentication
- Logging
- Load balancing

# EXTRA: HTTP cookies

A cookie is a small piece of data sent by the server to the browser. A cookie is used for 3 purposes:
1. Session management: logins, shopping carts, scores
2. Personalization
3. Tracking (recording, analyzing) user behavior

## Cookes and performance

Cookies increase latency because they need to be sent with every request and response.


 to mimic statefulness. A stateful HTTP is one which stores information between HTTP requests. The browser may, optionally, send the cookie back to the server in a further request.

# EXTRA: AJAX

AJAX (Asynchronous JavaScript and XML) does 2 key things:
1. Updates parts of the website without having to initiate a new HTTP request (i.e., refresh all the website)
  - More accurate: Makes server requests without reloading the page
2. Works with data from the server
  - More accurate: **Receives and works** with data from the server

AJAX works by making HTTP requests with Javascript. It uses the `XMLHTTPRequest` object (also known as XHR) to communicate with servers. It can send and receive files in various formats, like: HTML, XML, plain text, JSON, etc.