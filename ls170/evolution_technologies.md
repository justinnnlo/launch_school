# What to focus on

- How and why HTTP is evolving
- Functionality that browser APIs can provide
- Client-server isn't the only network paradigm

# HTTP evolution

## HTTP/0.9

- Characterized by simplicity
  - Sometimes called a "one-line" protocol
    - A request could be a single line (method and path) rather than a URI/URL
    - A response would be a single hypertext document, with no headers or metadata like status codes


## HTTP/1.0

A few developments influenced HTTPs evolution:
- More advanced browser's, like Netscape Navigator 1.0
- Telecommunication companies offering internet to homes via any telephone line
  - Powerful enough to download text files and small images
- WWW Consortium (W3C) and HTTP Working Group (HTTP-WG) were formed
  - Institutions that helped take over HTTP's development and standardize it
- Experiments to expand the functionality of HTTP/0.9

This lead to HTTP/1.0, which built on HTTP/0.9 by:
- Metadata through HTTP headers
  - Necessary given requests and responses became more complex — so servers and clients needed this metadata to deal with the request/response
- Adding 2 additional HTTP methods: `HEAD` and `POST`
- Request-URI request line portion could now be a path or absolute URI

## HTTP/1.1

- Connection reusage ("keepalive"): a major advance in reducing latency
  - Note: can still be used with HTTP/1.0 by adding "Connection: Keep-Alive" header to the request/response

## HTTP/2.0

## HTTP/3.0

# Web performance and HTTP Optimizations

## Browser optimizations

There are 2 broad types of browser optimizations:
1. Document-Aware optimizations: load the site more quickly by identifying and prioritizing resource fetching
  - E.g., load a page faster by prioritizing the resources that take the longest time like CSS layouts and JS

2. Speculative Optimizations: attempts to predict user actions
  - Based on learning user navigation patterns over time
  - Examples
    - Pre-resolving DNS names
    - Pre-rendering frequently visited sites
    - Opening a TCP connection in anticipation of an HTTP request when a user hovers over a link

## Latency: the limiter

This will always be an issue because:
1. The physical distances that need to be travelled
  - E.g. An application hosted in the US has a lower latency there than in Malaysia
2. The limitations of the materials used
3. Hardware efficiency

However, as developers we can mitigate latency:
- Eliminate unnecessary roundtrips
- Minimize the number of resources to be fetched
- Adding components to our system

## Network application optimizers
- Reducing the number of resources used by the application
  - Every image, video, stylesheet, and script adds to the number of requests, TCP connections and latency overhead
  - E.g., if a JS file is used in one page on a website but is loaded by the browser even if you are on another page
- Data compression techniques: reduce the size, rather than the number of resources
  - Leads to more efficient transfer — but note that round-trips won't be affected by this
  - Examples
    - Utilities like gzip can reduce text-based assets by 60%-80%
    - Compress images
    - [List of some resources here](https://developers.google.com/speed/docs/insights/MinifyResources)
- Reuse TCP Connections
  - We can re-use a TCP connection to fetch multiple resrouces — eliminating the RT latency for every handshake needed to setup a new connection
    - Known as "keepalive" connections
    - Default behavior in modern browsers: they attempt to reuse a TCP connection as long as the server's willing to cooperate
- DNS Optimizations
  - Problem: every initial request to connect to a domain will involve a DNS lookup to map the domain name of the application to the IP address of the host server
    - Implication: a browser cannot connect to the server and download resources
  - Possible solutions
    - Reduce the number of hostnames that need to be resolved
      - E.g. put all the resources under the same hostname as the application's
      - Caveats
        - Resources in a CDN have a performance gain which may offset the cost of a DNS lookup
        - Popular external resources may be saved in a user's browser cache — so may not need to be fetched
    - Using a faster DNS provider
- Caching on the server side
  - Caches: a short-term memory bank that stored recently accessed content by a user
    - Implication: content can be delivered more quickly next time it's requested
      - Particularly useful for dynamically generated server content — content that is produced when an application logic is run (unlike static HTML files)
    - Implication 2: the server has to perform less actions — as some content can be resued — thereby reducing server load and allowing it to respond more effectively to less requests
    - Caveat: server-side caching is complex and requires addressing several challenges like knowing what data to store and when to remove data to free the cache

# Browser networking APIs

## HTTP and real-time data synchronization

A limitation of HTTP and the request-response cycle is that it didn't consider real-time synchronization. Yet modern browsers provide us with APIs that can be used for this.

### XHR

XHR stands for XMLHttpRequest. XML is a markup language with a set of rules for document encoding. XML can also use data in JSON, HTML or plain text.

XHR enables clients to manage requests and responses asynchronously. Thus, it allos a webapp to perform actions while waiting for a server update. In contrast, in synchronous JS the webapp has to pause and wait for ther server's update before taking another action.

XHR is a key AJAX component. AJAX is a key building block in almost every modern webapp. Before AJAX and XHR, the entire page would've had to been refreshed to send or fetch any state updates between client and server. Yet with AJAX, we can now write some JS to respond to a user action, fetch some server data, and update part of the page through DOM manipulation.

XHR also allows polling. This refers to a script that runs in the background of the application and issues a periodic request (e.g. every 60 seconds) to the server for updates. The downside of polling is that it can be used for many unnecessary requests that take up computing resources. This is addressed with long-polling, where a request is issued but the server keeps the connection idle until an update is available. It only then issues a response — so it doesn't return an empty or negative response.

Note that XHR isn't the best performing solution for everything — it's opitmized for HTTP request and response communication, but doesn't support one-side message streaming to the other.

### SSE

Server-Side Events (SSE) is a networking API that allows server-to-client streams of text-based event data. Thus, the server can send real-time updates without requiring the client to send requests.

SSE works through the delivery of messages through a long TCP connection. Thus, instead of closing the TCP connection the client keeps it open to the server to receive future updates. This means that messages can be pushed to the client when they become available to the server — resulting in lower latency and message overhead.

The trade-offs from using SSE include:
- API only works with a client-server model (what other models are there?)
- Doesn't allow request streaming (e.g. streaming a large upload to the server)
- Binary streaming is inefficient because it's designed for UTF-8 data

### WebSocket

This is a simple and minimal API that allows us to send and receive data between client and server at any time. It's the only transport that allows either side to indpeendently message — without a request or response — each other over a persistent TCP connection. This is known as **bidirectional communication**.

Messages and application code sent over Websocket doesn't worry about parsing, buffering, and recosntrucintg received data.

Yet the simplicity of this API comes at the cost of:
- Missing state management
- Compressiong
- Caching
- Other browser servives

I don't think I understood WebSocket.

# Peer-to-peer networking

So far we've worked with the client-to-server model. Each participant has a clearly defined role in the exchange: the client makes a request and the server replies with a response. You can have many clients connected to the server, but the type of relationships stays the same.

Another network communication model is the peer-to-peer model. Here there isn't a clear separation of roles in the exchange. Instead of client and server each computer is a node within a network. Each node performs the actions of a client and server in the client-server model.

Note that the underlying infrastructure (e.g. many of the protocols) remains the same: what changes in a P2P network architectrure is how the various devices interact with each other in the architecture.

## Use cases

- No need to set-up and maintain servers to provide the system with functionality — you just need 2+ nodes
- Decentralization provides resiliency to the system: why it was a popular architecture for P2P file-sharing applications
- Communication doesn't need to be routed to a central point: may reduce latency through shorter paths between client and server
  - Particularly useful for real-time communication apps, like voice calls

## P2P Complexities

- Discovery (finding other nodes in the network)
  - Client-server model: a server has a fixed IP address that is always available
  - P2P model: a node's IP address may change, or be offline and online at different times
  - Possible solutions
    - Flooding: a message is sent to the network and each node forwards it until a specific number of network hops occur
      - Every node that can reply does so
      - E.g.: you're trying to download a file
        - You send a message trying to locate the file
        - Each node forwards it until a node replies that it has it
        - A connection with that node is established and the file is downloaded
    - Distributed Hash Table: essentially a table of key-value pairs
      - Key: what we want to retrieve (e.g. the filename of a file we're looking for)
      - Value: id of the network node that has the file
      - The DHT is split into parts to logically map the underlying structure of nodes within a network
    - Hybrid approach: having a central server that enables node discovery
      - Nodes have a client-server relationship and a P2P relationship when the nodes are connected
- Other problems include: connection negotiation and establishment, security, performance, scaling

# WebRTC

Historically, becoming a node required downloading 3rd party software or plugin.

WebRTC made things easier by:
- Providing real-time communication functionality within the browser
- Effectively allowing the browser to act as a node in a P2P communication network

What is WebRTC?

It's a collection of standards, protocols and APIs available in most modern browsers — abstracting the complexities of establishing P2P networks.

WebRTC uses UDP at the transport layer, which is connectionless and unreliable. It combines various protocols to establish and maintain sessions (STUN, TURN, ICE), security (DTLS) and congestion flow, avoidance, and some reliability (SRTP, SCTP).