Two of the most popular are the ***OSI model*** and the ***Internet Protocol Suite*** (also known as the TCP/IP model or DoD model).

> a protocol at one layer doesn't need to know anything about how a protocol at another layer is implemented in order for those protocols to interact. 

> The way these are implemented creates a system whereby a lower layer effectively provides a 'service' to the layer above it.


> In other words, a TCP segment isn't really concerned whether its data payload is an HTTP request, an SMTP command, or some other sort of Application layer data.

> The data payload is the key to the way encapsulation is implemented. The entire PDU from a protocol at one layer is set as the data payload for a protocol at the layer below. For example, a HTTP Request at the Application layer could be set as the payload for a TCP segment at the transport layer.

- Gives us abstraction, which is particularly true at the Application layer, where we might be using protocols like SMTP, HTTP, FTP, Mailto, etc.

