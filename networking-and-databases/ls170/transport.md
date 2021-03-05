# Focus

- How transport layer protocols enable communication between processes
  - What are multiplexing and demultiplexing?
    - How do ports work with IP Addresses for this?
- How is network reliability engineered?
- Understand the trade-offs
  - What are TCP and UDP?
  - What tradeoffs do each make?

# Communication between processes

IP essentially provides the minimum viable internet since it connects different networks into a larger one using IP addresses. But for modern networked applications we need 2 things IP cannot provide:
1. Direct connection between applications
2. Reliable network communication

## Understanging IP

IP is a system that allows messaging between hosts (i.e., devices). These hosts can be in the same network or in different networks (and are thus connected via IP, routers and DNS). We can get IP to send messages between them — but not more.

Limitation: a host can run many applications. How do we provide communication between applications that run on hosts rather than the hosts themselves? Or between 2 different applications running on the same host?

## Multiplexing and Demultiplexing

A host machine can have different channels: applications or processes running on it. For example, one could be listening to Spotify, another could be an email, another could be a website viewed on the browser, another could be the Figma native app.

The problem is that IP establishes a one-way communication between hosts — it isn't made to handle the many channels in a single host machine.

How can we send data inputs meant to multiple channels through the single communication avenue with the host? How does it understand what data is meant for which channel? How can we separate that data?

Multiplexing is the idea of sending multiple inputs over a single channel. Demultiplexing reverses multiplexing. Thus, If a server receives multiple inputs meant for different channels it uses multiplexing to receive all of it simultaneously and demultiplexes to separate the inputs and send it to the correct channel.

Note that multiplexing and demultiplexing can occur at different layers. At the transport layer it takes place through network ports, but at the physical layer multiplexing occurs in fiber optic cables, electricity or radio waves as they send multiple binary inputs simultaneously.

## Ports

A port is an identifier for a process running on a host. A host's identifier can range from 0 to 65535, but sections on this range are reserved for specific purposes:
- 0-1023 are assigned to processes that provide commonly used network services
  - HTTP: port 80
  - FTP: port 20 and 21
  - SMTP: port 25
- 1024-49151 are registered ports
  - E.g. Microsoft or Cisco have ports assigned that they use for specific services
  - On some OS some of these ports are used as *ephemeral ports* on the client side
- 49152-65535 are dynamic or private ports
  - They cannot be registered for specific use
  - Can be used customized services or allocation as ephemeral ports

For example, if you want to connect to a server via HTTP your device will *listen* to the web server on port 80.

Services running on client machines (e.g. in a browser) will use ephemeral ports assigned by the OS, such as 63456.

How do ports help us with multiplexing and demultiplexing?

Because the source and destination number for ports are included in the transport layer PDU. The structure of PDUs varies according to transport protocols but source and destination ports are in all of them. This information directs data to the appropriate port, allowing demultiplexing to happen. This data is then encapsulated alongside the full Transport PDU into the Internet/Network IP protocol packet and sent by IP.

Thus, end-to-end communication between applications on specific machines require both the IP Address and port numbers. The IP Address is what directs the IP packet to go from one device to the other, while the port numbers handle the transfer of information between specific applications running on the hosts. The combination of IP Address and port number is known as *communication end-point* or *socket*, for example `216.3.128.12:8080`.

Just to stress, the transport layer protocol handles the demultiplexing and assignment of data to the correct ports — be it the TCP or UDP.

## Netstat: finding open ports

```
Active Internet connections (including servers)
Proto Recv-Q Send-Q  Local Address          Foreign Address        (state)    
tcp6       0      0  joses-macbook-ai.1024  fe80::34a1:6b20:.1024  SYN_SENT   
tcp4       0      0  192.168.8.102.56302    104.17.208.240.https   ESTABLISHED
tcp4       0      0  192.168.8.102.56301    104.17.208.240.https   ESTABLISHED
tcp4       0      0  192.168.8.102.56300    104.17.208.240.https   ESTABLISHED
tcp4       0      0  192.168.8.102.56299    167.99.129.42.https    ESTABLISHED
tcp4       0      0  192.168.8.102.56297    185.63.144.5.https     ESTABLISHED
tcp4       0      0  192.168.8.102.56296    mad08s06-in-f3.1.https ESTABLISHED
tcp4       0      0  192.168.8.102.56295    mad07s10-in-f4.1.https ESTABLISHED
tcp4       0      0  192.168.8.102.56293    wn-in-f155.1e100.https ESTABLISHED
tcp4       0      0  192.168.8.102.56292    mad41s04-in-f3.1.https ESTABLISHED
tcp4       0      0  192.168.8.102.56291    mad08s05-in-f8.1.https ESTABLISHED
tcp4       0      0  192.168.8.102.56290    mad08s05-in-f14..https ESTABLISHED
tcp4       0      0  192.168.8.102.56287    mad41s04-in-f10..https ESTABLISHED
tcp4       0      0  192.168.8.102.56285    server-13-33-234.https ESTABLISHED
tcp4       0      0  192.168.8.102.56283    151.101.66.109.https   ESTABLISHED
tcp4       0      0  192.168.8.102.56281    104.26.4.214.https     ESTABLISHED
tcp4       0      0  192.168.8.102.56280    104.16.85.20.https     ESTABLISHED
tcp4       0      0  192.168.8.102.56279    104.16.85.20.https     ESTABLISHED
tcp4       0      0  192.168.8.102.56277    17.248.149.238.https   ESTABLISHED
tcp4       0      0  192.168.8.102.56276    mad06s25-in-f14..https ESTABLISHED
tcp4       0      0  192.168.8.102.56275    mad08s05-in-f14..https ESTABLISHED
tcp4       0      0  192.168.8.102.56274    mad41s04-in-f1.1.https ESTABLISHED
tcp4       0      0  192.168.8.102.56273    mad07s10-in-f3.1.https ESTABLISHED
tcp4       0      0  192.168.8.102.56272    mad08s06-in-f3.1.https ESTABLISHED
tcp4       0      0  192.168.8.102.56271    waw02s06-in-f14..https ESTABLISHED
tcp4       0      0  192.168.8.102.56270    mad01s24-in-f2.1.https ESTABLISHED
tcp4       0      0  192.168.8.102.56269    mad01s24-in-f2.1.https ESTABLISHED
tcp4       0      0  192.168.8.102.56268    mad07s22-in-f2.1.https ESTABLISHED
tcp4       0      0  192.168.8.102.56267    mad07s10-in-f4.1.https ESTABLISHED
tcp4       0      0  192.168.8.102.56266    mad07s10-in-f4.1.https ESTABLISHED
tcp4       0      0  192.168.8.102.56263    uklon5-vip-bx-00.https ESTABLISHED
tcp4       0      0  192.168.8.102.56261    server-54-192-10.https ESTABLISHED
tcp4       0      0  192.168.8.102.56258    ec2-15-236-69-95.https ESTABLISHED
tcp4       0      0  192.168.8.102.56057    192.168.8.100.58026    ESTABLISHED
tcp6       0      0  fe80::aede:48ff:.56059 fe80::aede:48ff:.49269 ESTABLISHED
tcp6       0      0  *.56057                *.*                    LISTEN     
tcp4       0      0  *.56057                *.*                    LISTEN     
tcp6       0      0  fe80::aede:48ff:.54445 fe80::aede:48ff:.49267 ESTABLISHED
tcp4       0      0  192.168.8.102.54387    17.57.146.165.5223     ESTABLISHED
tcp6       0      0  fe80::aede:48ff:.52330 fe80::aede:48ff:.49267 ESTABLISHED
tcp6       0      0  fe80::aede:48ff:.51036 fe80::aede:48ff:.49267 ESTABLISHED
tcp6       0      0  fe80::aede:48ff:.50559 fe80::aede:48ff:.49281 ESTABLISHED
tcp6       0      0  fe80::aede:48ff:.49464 fe80::aede:48ff:.49278 ESTABLISHED
tcp6       0      0  joses-macbook-ai.black fe80::b9b0:420d:.49329 ESTABLISHED
tcp6       0      0  joses-macbook-ai.1024  fe80::b9b0:420d:.1024  ESTABLISHED
tcp4       0      0  localhost.44960        *.*                    LISTEN     
tcp4       0      0  localhost.44950        *.*                    LISTEN     
tcp4       0      0  localhost.44970        *.*                    LISTEN     
tcp6       0      0  fe80::aede:48ff:.49174 fe80::aede:48ff:.49271 ESTABLISHED
tcp6       0      0  fe80::aede:48ff:.49164 fe80::aede:48ff:.49262 ESTABLISHED
tcp6       0      0  fe80::aede:48ff:.49163 fe80::aede:48ff:.49282 ESTABLISHED
tcp6       0      0  fe80::aede:48ff:.49162 fe80::aede:48ff:.49287 ESTABLISHED
tcp6       0      0  fe80::aede:48ff:.49155 fe80::aede:48ff:.49289 ESTABLISHED
tcp6       0      0  fe80::aede:48ff:.49161 fe80::aede:48ff:.49276 ESTABLISHED
tcp6       0      0  fe80::aede:48ff:.49160 *.*                    LISTEN     
tcp6       0      0  fe80::aede:48ff:.49159 *.*                    LISTEN     
tcp6       0      0  fe80::aede:48ff:.49158 *.*                    LISTEN     
tcp6       0      0  fe80::aede:48ff:.49157 *.*                    LISTEN     
tcp6       0      0  fe80::aede:48ff:.49156 *.*                    LISTEN     
tcp6       0      0  fe80::aede:48ff:.49155 *.*                    LISTEN     
tcp6       0      0  fe80::aede:48ff:.49154 *.*                    LISTEN     
tcp6       0      0  fe80::aede:48ff:.49153 fe80::aede:48ff:.59602 ESTABLISHED
```

Note that local and foreign addresses **acts as** communication end-points or sockets for the transfer of data between applications running on hosts.

## Sockets

This term is used in a slightly different way according to the context.

Conceptually it's what we outlined above: **an endpoint used for inter-process communication**. But it can be implemented in different ways.

- UNIX socket: a mechanism for local processes running in the same machine to communicate
- Internet socket (e.g. TCP/IP socket): a mechanism for networked processes to communicate, usually on different machines

Multiple networked processes can run on the same machine. For example, a webserver running on `localhost` and a browser connecting to that webserver. Thus, these 2 networked processes would use internet sockets but would be run in the single host rather than travel accross the networked infrastructure between 2 different hosts.

Sockets are implemented by instantiating *socket objects*. Many — but not all — follow  the Berkley sockets API model that defines specific functions like `bind()`, `listen()`, `accept()`, and `connect()`.

Why do we need to know about sockets?
- Understand how connections are made between applications
- Understand the difference between connection and connectionless communication
- Understand the difference between TCP and UDP

### Sockets, and connection and connectionless communication

By instantiating multiple socket objects we can implement a connection-oriented network communication between applications. In contrast, connectionless network communications happen through a single socket object.

Connectionless communication has a single socket object. This uses a single port number. Its object could call a `listen()` method to receive any incoming messages. When a message arrives it processes it and sends any replies as neccessary. Data can be received at any time, at any order, and from any source — but it isn't a problem.

Connection-oriented communication creates a socket object for each connection. It would also have a socket object listening for incoming communication. But when a message arrives, it creates a new socket object. This socket object isn't just created with its IP address and port number — it also uses the IP address and port number of the source that sent the message. Thus, this socket object would only listen for information that matches these 4 pieces of information:
- The host's IP Address
- The host's port number
- The source's IP Address
- The source's port number

The combination of these 4 pieces is called a four-tuple. Any messages that do not match an existing four-tuple are picked up by the original object, which then instantiates a new socket object for a new connection.

Connection-oriented communication using TCP allows for more reliability, but connection-less communication using UDP is more efficient because it doesn't need to instantiate a new socket object every time a communication is established between 2 networked applications.

# Network reliability

Protocols that provide the functionality for the lower levels of the communication network are inherently unreliable. The network up to and including the INternet Protocol is inherently unreliable because corrupted data is discarded — they have no provisions to replace or repair them. For example, Ethernet and the Internet Protocol use checksums in their headers or trailers to validate whether the data transported in frames or packets hasn't been corrupted — and if it is, it's just dropped.

However, we need data to be reliably transfered. How can we visualize a website that's missing an important resource? It may not even render.

What we need: a protocol to ensure data is received at the other end and is in the correct order.

## Building protocol reliability

Individual messages become curropt or lost. What protocols could we use to prevent that?

- The sender receives one message at a time with a sequence of numbers, and sets a timeout
  - If the message is received the receiver replies with an acknowledgement that uses the sequence number of the message to confirm what message was received
    - When the acknowledgement is received, the next message in the sequence is sent
  - If an answer isn't received by the timeout, it the sender sends the same message again with the same sequence number
    - Assumes: message wasn't received by the receiver or the response didn't reach it
    - If the receiver gets a duplicate message it assumes the sender didn't get the acknowledgement and sends another acknowledgement for that sequence number
      - The receiver also discards the duplicate message it received from the sender

![](https://da77jsbdz4r05.cloudfront.net/images/ls170/transport-reliability-acknowledgement-sequence-number.png)

This protocol thus has:
- In order delivery: data is sent and received in the correct order
- Error detection: checksum is used to identify corrupt data
- Handling data loss: timers and acknowledgements are used to retransmit missing data
- Handling duplication: sequence of numbers are used to identify duplicate data, which is discarded after retransmission

This type of protocol is known as "Stop-and-Wait" because it stops and waits until and acknowledgement is received.

Problem: the data is sent inefficiently — one at a time because of the "wait". This would increase latency. How can we improve this?

Pipelining is sending multiple messages in order without waiting for acknowledgement. The receiver still sends acknowledgements, but the system doesn't wait for individual pieces of data to each be acknowledged before sending more.

![](https://da77jsbdz4r05.cloudfront.net/images/ls170/transport-reliability-stop-and-wait-vs-pipelining.png)

There are different ways we can design this, such as Go-back-N and Selective Repeat. Yet the important things is that in these protocols the sender will have a "window" that represents the maximum number of messages can be in the "pipeline" at any point in time. Once it receives the acknowledgement for a message it stops counting that message towards it "window" and can send an additional one.

![](https://da77jsbdz4r05.cloudfront.net/images/ls170/transport-reliability-windowing.png)

What's going on in this approach? To improve latency, the protocol uses the spare bandwidth to send more data at a point in time. It still has to wait for acknowledgements, but this allows it to improve latency by working with multiple messages at a time. Here it spends more time transmitting messages rather than waiting for acknowledgements.

[Check this simulation that illustrates pipelining](http://www.ccs-labs.org/teaching/rn/animations/gbn_sr/)

# Transmission Control Protocol (TCP)

TCP's key feature is reliability to compensate for the inherent unreliability of the lower layer protocols like IP and Ethernet. It has to **"recover from data that is damaged, lost, duplicated, or delivered out of order by the internet communication system"**.

While TCP provides reliability it also takes a performance hit because it's designed to work through port connections, though it partly compensates this with some design decisions.

## TCP Segments

Segments are TCP's PDU. As other PDUs, it combines headers and payloads to encapsulate data from above.

![](https://da77jsbdz4r05.cloudfront.net/images/ls170/transport-tcp-segment-header.png)

The segment's source and destination port is used for multiplexing — just like UDP does it.

Other important fields include:
- Checksum: error detection
  - Performed by an algorithm that is also run by the receiving protocol (e.g. IP) to validate the data is received correctly
    - The receiver drops the segment if checksums don't match
  - Note: checksums performed at lower layers are left redundant by this one — which is why IPv6 removed it
    - It says that they're left redundant "to an extent" — **why would it only be partially redundant?**
- Sequence and Acknowledgement number: they together provide other elements of reliability
  - Essentially a more complex version of the reliability protocol designed right above
  - They provide:
    - In-order delivery
    - Handling data loss
    - Handling duplication
  - How this works is beyond the course's scope
- Window size: related to flow control

## 3-way handshake and TCP connections

A TCP connection is established using a 3-way handshake. (Note: there's a 4-way handshake that uses the additional `FIN` flag.)

The 3-way handshake refers to the sequence that needs to occur to establish a connection.
1. The sender sends a `SYN` segment
  - TCP segment with `SYN` flag set to `1`
2. The receiver responds with a `SYN/ACK` segment
  - TCP segment with the `SYN` and `ACK` flags set to `1`
3. The sender responds with the `ACK` segment
  - TCP segment with the `ACK` flag set to `1`
4. Receiver receives the `ACK` segment and establishes the connection

`SYN` refers to one of the key reasons of this process — to synchronize the sequence of numbers used during the connection.

After the sender replies with the `ACK` message it can start sending application data. Inversely, the receiver was to wait for the sender's `ACK` before sending any data back to the sender.

This is a more detailed annotation of the process:

|Client Start State|Client Action                                           |Client End State     |Server Start State      |Server Action                                 |Server End State|
|-|-|-|-|-|-|
|`CLOSED`     |Sends a `SYN` segment                                        |`SYN-SENT`           |`LISTEN`                |Wait for a connection request                 |`LISTEN`      |
|`SYN-SENT`   |Wait for the reply to it `SYN` segment and the server's `ACK`|`SYN-SENT`           |`LISTEN`                |Receive `SYN` and reply with `SYN ACK` segment|`SYN-RECEIVED`|
|`SYN-SENT`   |Received `SYN ACK` segment and replies with `ACK` segment    |`ESTABLISHED`        |`SYN-RECEIVED`          |Waits for the `ACK` it sent                   |`SYN-RECEIVED`|
|`ESTABLISHED`|Ready for data transfer, may start sending app data          |`ESTABLISHED`        |`SYN-RECEIVED`          |Receives `ACK` segment, connection established|`ESTABLISHED` |

This handshake process occurs every time we establish a connection — explaining the latency hit because of this round-trip process before data is exchanged.

![](https://da77jsbdz4r05.cloudfront.net/images/ls170/transport-tcp-thre-way-handshake-data-delay.png)

TCP does a few things to ameliorate the hit from the RTT of setting up a connection.

## Flow Control

This is a mechanism to prevent the sender from overwhelming the receiver. Data waiting to be processed is stored in a "buffer" that depends on the memory allocated by the OS and physaical resources available.

Each side of the connection tells the other how much data it's willing to accept via the `WINDOW` field in the TCP segment header. This is a dynamic value that can change during the connection based on the receiver's buffer capacity — thereby modifying how much data the sender sends.

## Congestion avoidance

Flow control stops the sender from overwhelming the receiver — but it doesn't stop it from overwhelming the network. A network is congested when more dtaa is being sent than it can handle — i.e., when it's bandwidth is exceeded. This doesn't stop the spread of data — the excess data is simply lost.

IP packets move through networks in a series of hops. At each hop, the packet has to be processed
  - The router at the hop runs a checksum to ensure data hasn't been lost
  - Checks the destination address and detemrines the route to the next hop

This processing takes time and a router can't process unlimited data, so routers store data in a "buffer" where data awaiting processing resides. The buffer overflows and data packets are dropped if there's more data than can fit the buffer.

This comes back to TCP because TCP retransmits lost data. Since we want to keep data retransmission to a minimum because it's inefficient, TCP uses the signals of lost data to modulate the size of the transmission window. The exact algorithm used by TCP to determine this varies according to the version of TCP.

## TCP disadvantages

Takes a latency hit because of the RTT taken to establish a connection.

Another potential issue is Head-of-Line (HOL) blocking. This is a general networking concept — it isn't specific to TCP. HOL blocking is about the issues created by the delay cause by delivering or processing one message in a sequence of messages. This "blocks" the delivery or processing of its subsequent messages in the sequence.

This relates to TCP because TCP pipelines its messages. However, if one is lost the subsequent messages can't be processed. Thus, the lost message needs to be resent and until it's received all subsequent ones need to be stored in the buffer — potentially creating queuing delays.

# User Datagram Protocol (UDP)

UDP avoids implementing flow control and congestion avoidance because it's a connectionless protocol.

The UDP's PDU is called a datagram. A datagram is very simple.
![](https://da77jsbdz4r05.cloudfront.net/images/ls170/transport-udp-datagram-header.png)

- Source port and destination port: used to route the message to the correct address and give information for the receiver to reply (if applicable)
  - By extension, this is how it provides multiplexing and demultiplexing
- Length: length in bits of the datagram and any encapsulated data
- Checksum: used for error detection

Unlike TCP, it doesn't solve the unreliability of lower layer protocols:
- Doesn't guarantee message delivery (no retransmission)
- Doesn't guarantee messages are delivered in the correct order
- Doesn't provide control flow or congestion avoidance
  - Note: because no data has to be retransmitted, so it avoids the problem that requires this patching
- Doesn't establish or track connections because it's connectionless

### UDP's strengths

UDP provides speed and simplicity. They can jsut send data without waiting for a connection to establish. Data can also be sent faster because it skips acknowledgements, retransmissions, and connection establishments.

It also avoids Head of Line blocking because messages don't need to be sent in the same order in this layer. (But are there any implications in this or other layers?)

If you're building an app with UDP you may want to implement some of the rules UDP doesn't natively supply. What you do depends on the decisions you make — just using UDP as a base template to build on top of.

For example, voice or video call applications justify the use of UDP over TCP. While some data might be lost — leading to occasional glitches — it benefits from improved latency. Similarly, it's better for there to be some glitches in online gaming rather than lags caused by latency.