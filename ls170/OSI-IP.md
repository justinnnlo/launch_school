The 2 most popular models to describe network communications are the Open System Interconnection and Internet Protocol Suite models. A Protocol suite is a collection of protoocls designed to work together.

These models are said to follow "layers" because they follow a proper order of execution in their corresponding order. Each protocol layer communicates with the protocol above and below it.

They're useful to troubleshoot networking problems when they come up.

## Why use protocol layers?

Alternatively, we could have comptuers communicate through even 1 single protocol (a single stack protocol). The problem with this is that it'd be very inflexible: any changes would require changing the entire application and protocol software. Thus, by layering protocols we can isolate a task to be done to a protocol that we can interoperatively add or remove.

<br>

# OSI

OSI standardizes the communication function by what each layer does at a technical level. It divides it into 7 layers of abstraction — from the physical network to the application layer. This model traces the flow of how data transfers in networks.

|Number|Layer Name|Function|Protocols|
|-|-|-|-|
|7|Application|Applications access network services|HTTP|
|6|Presentation|Ensures data is usable and encrypted||
|5|Session|Control connections between computer|TCP|
|4|Transport|Transfer data while keeping quality|TCP|
|3|Network|Transfer packets between nodes in different networks|IP|
|2|Data Link|Node-to-node-transfer|Ethernet|
|1|Physical|Transmission and reception of undstructured data|

Pneumonic:

- Application: All
- Presentation: People
- Session: Seem
- Transport: To
- Network: Need
- Data Link: Data
- Physical: Processing

*All people seem to need data processing*

## 1. Physical layer

The physical layer converts digital bits into signals: light, radio or electricity.

## 2. Data link layer

Organizes bits into frames and hop to delivery. Switches, Ethernet and MAC Addresses operate at this layer.

## 3. Network layer

Moves packets from source to destination and provide inter-networking. Routers — and thus IP addresses — operate at this layer.

## 4. Transport layer

Decides how much information should be sent at a time. This also provees a process for message delivery and error recovery.

## 5. Session layer

Establishes, manages and terminates sessions between 2 computers. For example, when we visit a website our computer has to create a session with the web server of that website.

## 6. Presentation layer

The layer at which the operating system operates with the data. The main functions the layer does with data include:
- Translation
- Encryption
- Compressions

## 7. Application layer

The end user interacts at this level. After he interacts with the Application layer data is sent downwards to the Presentation layer. Here **applications can access network services**.

# ISP Suite

|Number|Layer Name|Function|Example Protocols|
|-|-|-|-|
|4|Application|Applications access network services|HTTP, FTP, POP3, SMTP|
|3|Transport|Transfer data while keeping quality|TCP, UDP|
|2|Internet|Transfer packets between nodes in different networks|IP, ICMP|
|1|Link|Node-to-node-transfer|Ethernet, ARP|

This suite is named after the Transmission Control Protocol (TCP, in Transport) and Internet Protocol (IP, in Internet). **It was designed to be independent of networking hardware and should run across any connection media**.

# Key Protocols

## Application layer
- HTTP: sends hypertext files across the internet with HTTP GET/RESPONSE cycles
- SMTP, POP3, IMap4: email protocols

## Transport layer
- TCP: Transmission Control Protocol ensures that end-to-end connection is reliable
  - It breaks up (when applicable) data into multiple IP packets, verifies that they arrive to the recipient correctly, and reassemble the original file
- UDP (used datagram protocol): connection-less protocol — it doesn't guarantee delivery

Both UDP and TCP use the Internet Protocol, but which is used depends on how the application is designed.

TCP is a **connection-oriented protocol**. It has error recovery and re-transmission built-in. A TCP connection is set-up like a telephone line: a call has to be made and the phone has to be picked up; it's then closed when one hangs up.

A TCP connection is setup with the 3-way handshake to establish a reliable connection. The name comes because due to the communication of the client and server:
1. A client sends a SYN packet
2. The server ackowledges with a SYN/ACK packet
3. The client sends the ACK — and the connection is made

<br>

![](https://ars.els-cdn.com/content/image/3-s2.0-B9781597499613000030-f03-08-9781597499613.jpg?_)

The application can be confident that the data is error free because the TCP transport takes care of errors on the link.

In contrast, UDP is a connectionless protocol that doesn't correct or recover errors in messages. It sends a message but you have no idea whether it was received.

The benefit of UDP is that it's faster than TCP and reuslts in less network traffic because it doesn't require a network setup, and doesn't consume resources from holding a connection open.