# LS170

## 1-line summary

The network communication system uses independent, inter-operable protocols to solve the problems that allow us to exchange information in different ways between devices across networks.

Key words:
- Network communication system: we use a system of network communication. It's network communication because information is exchanged between or within networks of devices. It's a system because it's a variable layer of solutions that shape how that solution looks like and behaves.
- Independent, interoperable protocols: in network communications, a protocol is a set of rules for how to structure or handle information being transferred (could be between 2 applications in the same device or across multiple devices). Protocols do now know what the other protocols do, but they work with the adjacent ones to accomplish the overall task of transferring information.
- Problems: security, latency, bandwidth, reliability
- Networks: the system that allows 2 or more devices to exchange information
- Devices: objects that can join a network — either as an end device like a computer or cellphone or as a device to enable the exchange of information (router, switch, hub)
- Exchange information: 2 or more devices can send information (i.e., data) to or receive from another one. Some protocols (e.g. HTTP) structure the messages to standardize and help devices interpret the information, while others deal with problems related to how it is send (e.g. TCP, TLS).

# Internet

## 1-line summary

The internet is a layered communication system that allows devices in different networks to communicate through a series of protocols, thereby becoming a network of networks.

Key words:
- Layered communication system: a combination of independent, interoperable protocols that address specific problems in the system
- Devices to communicate across networks: 2 or more devices in different networks can exchange information
- Network: a system that allows 2 or more connected devices to exchange information
- Network of networks: a system that connects different networks — and by extension the devices that are connected to each individual network

## 1-paragraph summary

The internet is a layered communication system that allows devices in different networks to communicate through a series of protocols, thereby becoming a network of networks. At its most basic level, the internet is a collection of networks. It's formed from Local Area Networks — networks of devices connected through hubs or switches — which themselves are connected to other networks through routers. Thus, the internet is a descentralized system because it is based on the communications of many networks and there is no one who controls it. IP uses this system of inter-connected networks to connect devices via DNS and IP addresses, and to send data exchanged between applications or devices through packets. Yet the internet is more than routers and IP because it depends on its cooperation with other protocols for it to work. In this layered system, the protocol below provides services to the data of the protocol above. Thus, the internet is a layered system of network protocols of which IP is only one.

## OSI vs TCP/IP model

The Open Systems Interconnection (OSI) and TCP/IP model are both abstractions of how **a** networked communications system works — given there are multiple networked communication systems in the world.

The OSI model is based on the functionalities of each layer. In contrast, the TCP/IP model is based on the scope of communications at each layer. This explains the differences in both models.

OSI:
- Application: manipulates data to present the user with a meaningful output. A web application is NOT part of the application layer — it only sends data to and receives from the application layer.
- Presentation: processes the data from/for the application layer — e.g. encrypting on the server's end and decrypting on the receiver's end so the message has syntax that the application layer can understand. Thus, it PRESENTS the data to be manipulated by the application layer.
- Session: opening and closing communication between 2 devices — e.g. maintaining a session open until all the data has been transmitted and closing it afterwards to avoid wasting resources
- Transportation: responsible for reliable end-to-end communication between devices
- Network: allows the transfer of data between devices in different networks through the best physical path
- Link: the interface between the physical layer and the logical layers above — it transfers data between 2 devices on the same network (e.g. a switch and a computer) — and deals with intra-network flow control and error control
- Physical: how a communication system converts data into binary bit streams and transferts it across devices like hubs and switches and fiber optic cables. Devices at this level agree on conventions for what a 1 and 0 looks like.


 TCP/IP:
- Application: scoped at the level of device application data — and thus the messages sent, their structure and security
- Transportation: scoped at the level of the ports and sockets that allow specific applications and processes in devices to communicate between each other
- Internet: scoped at the level of networks and the transmission of data BETWEEN a network
- Data Link: scoped at the level of physical devices (routers, hubs, switches, fiber optic cables) and their role in the transmission of data WITHIN a network

## Protocols

A protocol is a set of rules. For example, Caesar's Cipher is a protocol to encrypt and decrypt a message. In the context of network communications, a protocol is a set of rules related to the system of network communications. Thus, it refers to how to structure a message, process it, or transmit it.

Protocols work in a layered system of communications by providing services to the protocol above through its PDU, and sending their PDU to the protocol below. A PDU is a Payload Data Unit, and is comprised of 3 elements: header (metadata), payload and footer/trailer (metadata). A PDU is encapsulated by the layer below as its payload. Thus, in the context of network protocols encapsulation involves placing the PDU of a protocol above into the payload of the PDU of the protocol below. It's still the same concept as in OOP — placing data in a construct — but in the data and construct varies. In OOP, the data was attributes and behaviors and the construct was objects. In network protocols, the data is a PDU and the construct is also a PDU.

Note that within each layer there can be multiple protocols operating at each time.

## Physical Network

Data is processed and transferred across networked devices. A networked device is an object that can connect to a network — and thus exchange information with 1 or more other devices.

The devices in the physical network vary:
- The client or server that originate the message
  - Can vary from: desktop or laptop computers, to networked refrigirators, to cellphones and smart watches
  - They have a MAC address
- The hub or switch that forms a LAN
  - They create a geographically-constrained network, where for a device to join a network it has to be connected to said hub or switch — thus imposing a physical limitation to who can join
- The routers that process and direct the flow of data
  - They connect the LAN to other networks
  - They use a MAC table to map the MAC addresses to an IP address, and are what allows IP Addresses to work
  - They process data that they receive (i.e., that hops in that router)
    - Route data to the best physical path they can take to their destination
    - Use checksum to detect errors, and drop the packets that have errors
    - Buffer data when its bandwidth is exceeded (though it drops packets if the buffer overflows)
    - Alter the packet header to take into account that it has hopped there
      - To ensure packets don't hop forever/are dropped if they don't get to a location => **what's the term???**
- Core network
  - Sends signals of bit streams (binary data)
  - At this layer the data is not logical or structured: it's just 1s and 0s
  - Signals can take multiple forms: waves, light, electricity
    - Light (e.g. fiber optic cables) tends to be reliable but costly
    - Electricity (e.g. copper wires) are cheaper but have more signal loss
    - Waves (e.g. WLAN) have less geographic constrains than light or electricity but have high signal loss
  - Devices need to agree on what the bit streams represent — on what a 1 and a 0 look like

Even though at the physical layer data is sent as a stream of binary signals it is not unstructured. Rather, the structure come from Ethernet Frames. Though Ethernet is a protocol family of the Data Link rather than Physical layer, the physical layer translates Data Link PDUs into binary. Thus, physical layer bit streams have structure — even though it may not seem so when looking at them in isolation.

### Latency and bandwidth

Latency and bandwidth are the 2 key metrics when analyzing the physical network, and they have upstream repercussions on all the other upper layers.

Latency is a measure of speed. Latency measures how fast data is sent between a source and destination. It's typically measured in seconds, but we could use any measurement of time. If it takes 3s for data to move from point A to B, its latency was 3s.

Metrics that break down latency include:
- Propagation delay: ???
- Transmission delay: the time it takes for data to hop between devices
  - For example, the interframe gap that's used for devices to separate one frame from another in the Ethernet protocol adds to the transmission delay
- Queuing delay: time the data took to queue (e.g. when data was queued in a router's buffer)
- Processing delay: time it took for the devices to process the data as it hopped through it

Other
- RTT (Round Trip Time): the time it takes for data to go to its destination and return to the source (i.e., signal sent to acknowledgement received)
- Last-mile latency: the latency between the ISP and device — i.e., the last-mile transmission of data as data hops through local networks rather than travel through the core network

Bandwidth is a measure of capacity. A network's bandwidth is how much data it can send at any given measurement of time (typically a second). Thus, a network cannot transfer more data than its bandwidth size.

## Link/Data Link layer

### 1-line summary

The data link layer structures (**frames**) and transmits information between devices (**addressing**) in the same network.

### 1-paragraph summary

The data link layer structures and transmits information between devices in the same network. It's also the last layer in the OSI model where encapsulation occurs: the physical layer doesn't have a PDU, it translates PDUs into binary streams of signals. One of the key protocol families is Ethernet. Ethernet's PDU are called frames. Frames break up IP packets, place them in their payload, and transfer them across devices in the same network. We can differentiate packets and frames just from the header: while packets have the IP address and port number, frames have the device's MAC address to ensure that within the network it finds the correct device. Thus, while packets are used for inter-network communication we need frames and the MAC addresses they contain in their headers to ensure that our data arrives to the correct device. Frames add structure to the bit stream of the physical layer (which translates the frame into bits). This structure is maintained because frames use a structure that depends on fixed number of bytes to differenciate each field of data — including that of the payload. Thus, binary signals that represent frames maintain keep this order.

### Ethernet

Ethernet is a Link/Data Link protocol that takes the PDU of the Internet/Network layer and processes it for transportation within devices of a local network. Some characteristics include:
- Unreliable: drops packets and doesn't retransmit Ethernet frames
- Structures the data into Ethernet frames: metadata in headers, an optional body and a trailer/footer — each in a specific size range that needs to be respected
  - Headers: source and destination MAC Address (IP address and port number are at the Network and Transport layers)
  - Payload
  - Trailer: Frame Check Sequence is a checksum used for error detection
- Interframe gap: used so that devices can differentiate one frame from another


## Internet/Network layer

### 1-line summary

The internet/network layer allows devices in different networks to communicate with each other through a system of IP addresses and the DNS.

- IP Addresses: a unique but variable identifier of a device connected to the internet
  - Unique: no 2 devices can share an IP Address
  - Variable: an IP address is router- rather than device-specific. Thus, if I take my computer and connect it to another network its IP Address will change.
  - Each router is assigned a network address (that ends with a 0, like `109.156.106.0`) which is how other routers know the IP addresses that the router holds
    - How it knows: in IPv4 sections are broken into bytes, which can go from 0 to 255 (i.e., 256 different numbers using 0 index) — the network address is 0 and broadcast address is 255, and all the device IP addresses in that router are 1 to 254
    - This is how the hierarchical structure is created
  - Routers use routing tables to determine the best path to send data to
- DNS: a decentralized system of servers that are structured hierarchically and logically in order to get the IP Address of a URL. A DNS request initiates an IP Address lookup. The request is processed by the first server that takes the request, which uses the URL to map to an IP Address in a DNS database. The server which forwards the request up the hierarchy until it's found.
- MAC (Method Access Control): a unique and device-speficic identifier of a network device. MAC addresses are assigned by a body. Additionally, they're illogical (there isn't a structure or logic to why they're given) and rarely changed. This is why they're sometimes referred as *burned* in a device.
  - MAC addresses could theoretically be used for inter-network communication but aren't because there isn't a logic to them — so it'd be difficult to find a device in the internet
- MAC table: a table within a router that maps a MAC address to the device's IP address. This is what allows routers to send data meant for an IP Address to that device.

### 1-paragraph summary

The internet or network layer provides 2 key services: encapsulation and routing. It encapsulates the PDU of the transport layer and places it into the payload of its PDU (likely an IP packet), and stores information on how to handle the packet in its header. This includes details like: the IP protocol to use, the packet's time to live (TTL) so that it doesn't bounce endlessly in the network, etc. The 2nd service is routing through the IP Addressing system, which uses a logical and hierarchical structure to find network-connected devices. This addressing system works because routers are assigned 254 IP addresses each (plus the network and broadcast address), which they use to assign to devices that connect to its network. This implies that to communicate with a device in another network you need its IP address, which tells you its router, and that in turn tells you the device (through its MAC address) that uses that IP Address.

### URL vs URI

A URI is a unique resource identifier. It's used to identify a resource. A URL is a subset of a URI in that it's also used to uniquely identify a resource but it also provides the service of finding the resource's location. It finds the location through the DNS, which maps a URL to the IP Address found in a DNS server's database.

### URL encoding

In a URL some characters will need to be encoded so that they can be safely transmitted. Encoded characters are characters that cannot be placed in a URL and need to be represented by `%` followed by 2 hexadecimal characters.

Characters that require encoding include:
- Reserved characters when not used in their context: e.g. `?` and `&`
- Unprotected characters that could be altered during transfer: e.g. " " (space)
  - Spaces may be added or removed by word-processing programs
  - `<` and `>` are used as delimeters around URLs in free text
  - Quotemarks `"` or `'` are used in some systems to delimit URLs
  - `#` needs to be encoded because it has the special meaning of an HTML anchor
  - `%` is unseafe because it's used to encode other characters
- Non-ASCII characters: are not valid in a URL


### What are URL query strings?

URL query strings sends additional data to the server. Query strings are based on name-value pairs. For example, in inventory page of an e-commerce store the query strings could might tell the page how to filter and sort the inventory.

Benefits:


Downsides:
- They are insecure: why we cannot pass sensitive data through query strings, such as usernames and passwords
- Size: they need to respect a size limit — they cannot have an infinite length

# Transport Layer

## Transport layer summary

### 1-line

The transport layer i) encapsulates and processes data from the upper layer and ii) sends the data between specific applications in devices by using device sockets.

### 1-paragraph

The transport layer provides end-to-end communication by encapsulating and providing services to the upper layer PDU and transmitting data through specific sockets. It's also important in sending data efficiently by sending multiple signals over a signle channel — which is allowed through multiplexing and demultiplexing. Transport layer protocols vary mostly by the services they provide, and the trade-offs that these represent. The 2 most used are TCP — which provides reliability at the expense of latency — and UDP — which provides simplicity at the expense of reliability. Thus, there isn't a "better" or "worse" solution because this has to be analyzed holistically with the entire project and the trade-offs of each protocol in mind.

## Ports and sockets

### 1-liner

A port is an identifier for a process running on a device, and the combination of an IP address and port is a communication end-point and a socket.

### Paragraph

~~A port within a device tells the device what application or process to send it to.~~ **A port is an identifier for a process that is running on a host**. This is how data sent over the internet knows where the process in the device it should be sent to. The combination of an **IP address and a port is a communication end-point** (because it's where communication is header). The combination of an IP address and port is a socket, hence why sockets are communication end-points.

### More on ports and sockets

The port's identifier is an integer between 0 and 65535, though some sections are reserved for specific services. For example, port 80 is reserved for HTTP and port 25 for SMTP.

Data isn't taken in by the port itself to the application — it's done through a socket. A socket is an object that can be instantiated by a device to interact with external data being sent to the device. A device can instantiate many sockets, which are referenced by numbers. By default, networked devices have a socket that listens to incoming communication.

Yet how that communication is conducted and its contents determine what happens. For example, data sent via UDP will only be taken in by the listening socket. In contrast, data sent via TCP will tell the listening socket to instantiate a new socket through a successful TCP handshake to set-up a dedicated communication channel between the 2 applications that are exchanging information. A socket instantiated through TCP will use an ephemeral or dynamic ports, because their identifiers can be reused for different connections.

## TCP summary

### 1-line

The TCP protocol provides a series of services for applications so that application-to-application communication is reliable.

### 1-paragraph

TCP enables reliable application-to-application communication. It provides a series of services that create reliability at the expense of latency, such as:
- Authentication by establishing connections between device sockets
- In-order delivery so that data arrives in the correct sequence
  - **But which can generate latency through Head-of-Line blocking** and from the overhead of establishing a connection between applications
- Data recovery by retransmitting lost data
- Error detection with checksum algorithms
- Multiplexing and demultiplexing with fourtuples
- Handling duplication

To compensate for the latency overhead that these services generate, TCP partly compensates through flow control and network congestion mechanisms. Flow control is used by TCP to redirect its segments through the best possible route (note: didn't IP route packets in the most efficient way?) while its network congestion mechanisms are used to reduce the window of segments when data retransmission increases (which signals bandwidth overflow).

### TCP Handshake (data synchronization!)

The TCP handshake is a 4-step process:
1. The client sends a `HelloServer` message with the `SYN` flag
2. The server receives `HelloServer` and acknowledges with `SYN ACK`
3. The client receives the server's acknowledgement and replies with `ACK`
4. The server receives the client's `ACK` — establishing the connection

After the server receives the client's reply to its acknowledgement it establishes a connection with the client — thereby instantiating a socket that uses a dedicated port for that. Note that the client can start sending data after it sends its response to the server's acknowledgement.

But what's going on with `SYN` and `ACK`? And why do we need a 4-step process?

Both client and server each use a sdifferent equence number to keep track of the messages that have been exchanged. The ISN (initial sequence number) is a randomly chosen integer. This is how they can identify a duplicate and make sure that the message exchange is correct.

The problem is: if the Initial Sequence Number of both client and server are chosen randomly, how can the other know what it is? That's why `SYN` and `ACK` are exchanged.

That's also why we need a 3-way handhsake.

To avoid a situation where a synchronization message isn't received by the other party, thereby causing potentially critical problems, a handshake requires an acknowledgement. Thus, the client's Initial Sequence Number is only confirmed when the server replies with `SYN`. Similarly, the server's Initial Sequence Number is only confirmed when the client replies with `ACK`. If this third message weren't sent then the server wouldn't have a confirmation that the client knows its Initial Sequence Number — which is critical to ensure synchronized communication if the server is meant to reply. Thus, a 2-way handshake would enable synchronization only if the client were the only one sending messages.

If data were not synchronized, TCP wouldn't be able to:
- Identify (and handle) duplicated messages
- Identify (and handle) lost segments

### Flow control and congestion avoidance

## UDP summary

### 1-line

The UDP protocol provides simple services for applications that need low latency at the expense of reliability in their application-to-application communication.

### 1-paragraph

UDP also provides end-to-end application communication but does so with more simple services to achieve lower latency, thus avoiding the overhead. Partly it does so by being a connection-less protocol, thus avoiding the RTT latency of sending a connection request and receiving the acknowledgement. It also avoids other services like recovering data and in-order delivery. Thus, its key services are ensuring communication between the end applications by using the IP Addresses and ports of source and destination, and providing multiplexing and demultiplexing.3

## Multiplexing and demultiplexing

### 1-line

Multiplexing is the process of sending different streams of data through the same channel by combining them into a single stream and demultiplexing allows us to reverse the multiplexed signals and allow the data to travel to their appropriate end-points (an end-point is the final destination).

### 1-paragraph

Multiplexing and demultiplexing work together to improve latency by sending different streams of unrelated data down a single channel without compromising on reliability. They work at the Transport layer through the combination of source and destination IP Addresses and ports. Given that Transport PDUs have this metadata in their headers they can be sent with unrelated PDUs down a single channel, which is called multiplexing. Demultiplexing is the inverse: separating the PDUs that arrive in the single channel and sending them to their respective device and process using the IP Address and port. At the level of the transport layer demultiplexing is possible because each process in a device has a unique channel in its port. Yet these concepts appear in other layers besides the Transport: for example, the physical layer uses multiplexing to send through the core network unrelated signals.

- Multiplexing is sharing a single communication channel for multiple signals. This is possible by combining the signals. For example, a single telephone line can carry multiple calls.
- Demultiplexing is a process that reverses multiplexing to allow data to travel to its end-point.


# HTTP

## 1-line summary

# TLS

## 1-line summary

TLS is a Session layer protocol that secures the message being sent through the network.

- Authentication (asymmetric encryption)
- Secure message exchange (symmetric encryption)

# Evolution of Networked Technologies

## 1-line summary

OSI model
- Application: manipulates data to present meaningful data to the end user. This, this does not relate to the application being used — but to the protocols that manipulate the data sent by the application or to the application.
  - E.g., HTTP manipulates the data by structuring a request or response, and using those details to give the end user a meaningful output
- Presentation: processes the application-layer data so that it can be used by upper or lower layers. For example, data sent by the application layer is encrypted and compressed by the presentation layer before sending the data to the Session layer. Inversely, data sent by the Session layer is decrypted so that the application layer protocol can manipulate it.
- Session: opens and closes the session between two devices.
- Transport: provides a series of services to create reliability in the network communication system, and to send the data between specific ports in devices.
- Network: routes data in the most efficient way between 2 devices in different networks.
- Link: interfaces the logical upper layers with the physical layer by transmitting data between devices within a network
- Physical: sends streams of bit signals across devices that have agreed on how to interpret the signals.

OSI:
- Application: manipulates data to present the user with a meaningful output. A web application is NOT part of the application layer — it only sends data to and receives from the application layer.
- Presentation: processes the data from/for the application layer — e.g. encrypting on the server's end and decrypting on the receiver's end so the message has syntax that the application layer can understand. Thus, it PRESENTS the data to be manipulated by the application layer.
- Session: opening and closing communication between 2 devices — e.g. maintaining a session open until all the data has been transmitted and closing it afterwards to avoid wasting resources
- Transportation: responsible for reliable end-to-end communication between devices
- Network: allows the transfer of data between devices in different networks through the best physical path
- Link: the interface between the physical layer and the logical layers above — it transfers data between 2 devices on the same network (e.g. a switch and a computer) — and deals with intra-network flow control and error control
- Physical: how a communication system converts data into binary bit streams and transferts it across devices like hubs and switches and fiber optic cables. Devices at this level agree on conventions for what a 1 and 0 looks like.

OSI model review (Wentz info)
- Application:
- Presentation: processes data so that it's readable for all machines. It may also provide other services related to how the data is presented, like encryption and compression.
  - Note: why wouldn't it be readable for machines?
- Session: establishes a session-level connection between 2 **presentation entities**, synchronizes their dialogue and manages the data transfer
- Transport: end-to-end transmission of data. May include: flow control, error detection and data recovery.
- Network: addressing and routing
- Link: connection between 2 adjacent nodes on the same network
- Physical:

TCP/IP model
- Application: end-to-end communication between applications
- Transport: end-to-end communication between devices (or processes? because doesn't the transport layer use sockets?)
- Internet: logical point-to-point communication
- Link: physical point-to-point communication

- Internet is logical because IP or similar protocols are logical systems that identify the source and destination.
- Link is physical because it depends on the physical transfer of data between devices
- Internet and Link are point-to-point because they deal with the transfer of data across all networked devices between the source and destination (i.e., they deal with each point enroute between source and destination)
- In contrast, Application and Transport are end-to-end because they deal with the connection of the end devices or applications rather than the devices enroute to them (by extension, not with the points in the route)
