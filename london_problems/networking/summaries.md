# Internet

The internet is a vast network of networks. It is comprised of both the network infrastructure itself (devices, routers, switches, cables, etc) and the protocols that enable that infrastructure to function.

Protocols are systems of rules. Network protocols are systems of rules governing the exchange or transmission of data over a network.

Different types of protocol are concerned with different aspects of network communication. It can be useful to think of these different protocols as operating at particular 'layers' of the network.

Encapsulation is a means by which protocols at different network layers can work together.

Encapsulation is implemented through the use of Protocol Data Units (PDUs). The PDU of a protocol at one layer, becomes the data payload of the PDU of a protocol at a lower layer.

The physical network is the tangible infrastructure that transmits the electrical signals, light, and radio waves which carry network communications.

Latency is a measure of delay. It indicates the amount of time it takes for data to travel from one point to another.

Bandwidth is a measure of capacity. It indicates the amount of data that can be transmitted in a set period of time.

Ethernet is a set of standards and protocols that enables communication between devices on a local network.

Ethernet uses a Protocol Data Unit called a Frame.

Ethernet uses MAC addressing to identify devices connected to the local network.

The Internet Protocol (IP) is the predominant protocol used for inter-network communication.

There are two versions of IP currently in use: IPv4 and IPv6.

The Internet Protocol uses a system of addressing (IP Addressing) to direct data between one device and another across networks.

IP uses a Protocol Data Unit called a Packet.

# Transport layer

Multiplexing and demultiplexing provide for the transmission of multiple signals over a single channel

Multiplexing is enabled through the use of network ports

Network sockets can be thought of as a combination of IP address and port number

At the implementation level, sockets can also be socket objects

The underlying network is inherently unreliable. If we want reliable data transport we need to implement a system of rules to enable it.

TCP is a connection-oriented protocol. It establishes a connection using the Three-way-handshake

TCP provides reliability through message acknowledgement and retransmission, and in-order delivery.

TCP also provides Flow Control and Congestion Avoidance

The main downsides of TCP are the latency overhead of establishing a connection, and the potential Head-of-line blocking as a result of in-order delivery.

UDP is a very simple protocol compared to TCP. It provides multiplexing, but no reliability, no in-order delivery, and no congestion or flow control.

UDP is connectionless, and so doesn't need to establish a connection before it starts sending data

Although it is unreliable, the advantage of UDP is speed and flexibility.

# HTTP

The Domain Name System (DNS) is a distributed database which translates a domain name such as google.com to an IP Address such as 216.58.213.14.

A URI is an identifier for a particular resource within an information space.

A URL is a subset of URI, but the two terms are often used interchangeably.

URL components include the scheme, host (or hostname), port, path, and query string.

Query strings are used to pass additional data to the server during an HTTP Request. They take the form of name/value pairs separated by an = sign. Multiple name/value pairs are separated by an & sign. The start of the query string is indicated by a ?.

URL encoding is a technique whereby certain characters in a URL are replaced with an ASCII code.

URL encoding is used if a character has no corresponding character in the ASCII set, is unsafe because it is used for encoding other characters, or is reserved for special use within the url.

A single HTTP message exchange consists of a Request and a Response. The exchange generally takes place between a Client and a Server. The client sends a Request to the server and the server sends back a Response.

An HTTP Request consists of a request line, headers, and an optional body.

An HTTP Response consists of a status line, optional headers, and an optional body.

Status codes are part of the status line in a Response. They indicate the status of the request. There are various categories of status code.

HTTP is a stateless protocol. This means that each Request/ Response cycle is independent of Request and Responses that came before or those that come after.

Statefulness can be simulated through techniques which use session IDs, cookies, and AJAX.

HTTP is inherently insecure. Security can be increased by using HTTPS, enforcing Same-origin policy, and using techniques to prevent Session Hijacking and Cross-site Scripting.

Only the path and parameters can pass information to the application via de URL — the host and port only to point the location of the application.

An HTTP methods are values that identify the type of HTTP request. **Why is it imprecise to describe them as metadata?**

HTTP is a text-based protocol. HTTP Request and Responses involve sending text between the client and server

In order for the protocol to work, the Request and Response must be structured in such a way that both the client and the server can understand them.

With HTTP/1.1, the end of the headers is indicated by an empty line.

The Content-Length header can be used to indicate the size of the body. This can help determine where the HTTP message should end.

# TLS

HTTP Requests and Responses are transferred in plain text; as such they are essentially insecure.

We can use the Transport Layer Security (TLS) Protocol to add security to HTTP communications.

TLS encryption allows us to encode messages so that they can only be read by those with an authorized means of decoding the message

TLS encryption uses a combination of Symmetric Key Encryption and Asymmetric Key Encryption. Encryption of the initial key exchange is performed asymmetrically, and subsequent communications are symmetrically encrypted.

The TLS Handshake is the process by which a client and a server exchange encryption keys.

The TLS Handshake must be performed before secure data exchange can begin; it involves several round-trips of latency and therefore has an impact on performance.

A cipher suite is the agreed set of algorithms used by the client and server during the secure message exchange.

TLS authentication is a means of verifying the identity of a participant in a message exchange.

TLS Authentication is implemented through the use of Digital Certificates.

Certificates are signed by a Certificate Authority, and work on the basis of a Chain of Trust which leads to one of a small group of highly trusted Root CAs.

Certificates are exchanged during the TLS Handshake process.

TLS Integrity provides a means of checking whether a message has been altered or interfered with in transit.

TLS Integrity is implemented through the use of a Message Authentication Code (MAC).

# Evolution networked Technologies

HTTP has changed considerably over the years, and is continuing to change.

Many of the changes to HTTP are focused on improving performance in response to the ever increasing demands of modern networked applications.

Latency has a big impact on the performance of networked applications. As developers and software engineers we need to be aware of this impact, and try to mitigate against it through the use of various optimizations.

In building networked applications, there are tools and techniques available to us that work around or go beyond the limitations of basic HTTP request-response functionality.

For certain use cases a peer-to-peer architecture may be more appropriate than a client-server architecture.