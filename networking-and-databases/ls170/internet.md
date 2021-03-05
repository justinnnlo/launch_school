# What is the Internet?

The internet is a "network of networks".

The most basic level of a network is 2 devices connected in such a way that they can exchange data (i.e. communicate). For example, you could connect 2 computers with a LAN cable and configure their network setting so they form a distinct network.

[Khan Academy video](https://www.khanacademy.org/partner-content/code-org/internet-works/v/what-is-the-internet)

## History of the internet

Successor of ARPANET: a communication system that might survive a nuclear attack. Break messages into blocks and send it in every possible direction through the mash network — a decentralized, experimental packet network.

Internet made up of many independently operated networks. Fully distributed, no central control deciding how packets are routed or who connects with whom. Incentive for end-to-end connectivity because there's network effects: the value of having internet is related to the number of people connected to it.

## Local Area Networks

But hwat if we want to connect multiple computers? A LAN cable would be insufficient — we need a **network bridging device**. This could be a device such as a hub or a switch. The computers all connect to this device, which forms the network.

The scope of communication in LAN systems is limited to the devices that are connected to the switch or hub. This is why LAN is "local" — because there's a geographic limitation in the sense that to join the network we need the device to be connected to the switch or hub.

When LAN systems are connected wirelessly rather than plugged in via a cable this implementation is called WLAN (Wireless LAN).

## Inter-network Communication

Routers allow networks to communicate between themselves. Routers are network devices that can route traffic to other networks. This is the gateway in and out of a network between different LANs.

## Network of Networks

The internet is essentially a huge amount oof networks connected together. Systems of routers direct the network traffic between all of these sub-networks.

<br>

# Protocols

The many networks that make up the internet have themselves many components: computers, cellphones, lightbulbs, cars, watches, toasters, security alarms, etc. They all connect via different makes and models of hubs, switches, and routers to different server configurations — and each running their respective softwares.

This creates a lot of complexity:
- Browser being used
- Device maker
- OS (and OS version)
- Router make and model
- Type of webserver and hardware it's running in

Protocols, a system of rules, allow this to work despite the complexity. In terms of computer networks a protocol is **a set of rules governing the exchange or transmission of data**.

Some of the protocols include:

- IP
- SMTP
- TCP
- HTTP
- Ethernet
- FTP
- DNS
- UDP
- TLS

There are so many protocols because different protocols were developed to:
1. Address specific aspects of network communication
2. As the above, but in a specific way or for a specific use-case

For example, TCP and UDP are 2 protocols that address the same aspect of communication: the transfer of messages between applications. However, they do so in different ways.

Inversely, HTTP and TCP are 2 protocols that address different aspects of communication. TCP handles the transfer of messages between applications and HTTP handles the structure of the messages.

<br>

# Layered System

We can think of protocols as functioning within layers of an overall communications system. By thinking of protocols as a layered system we can focus on a specific layer to understand what's happening at that specific level of the system.

In network communication there are 2 popular layered systems: Open Systems Interconnection (OSI) and Internet Protocol Suite (also know as TCP/IP or DoD model).

|OSI|TCP/IP|Comment|
|--------------|-------|-|
|Application|Application|TCP/IP Application mostly maps to OSI's top 3 layers|
|Presentation|Transport|TCP/IP Transport mostly maps to OSI's Transport|
|Session|Internet|TCP/IP Internet mostly maps to OSI's Network|
|Transport|Link|TCP/IP Link mostly maps to OSI Data Link and Physical|
|Network||
|Data Link||
|Physical||

<br>

So broadly speaking, it would more closely look like:

|OSI|TCP/IP|
|--------------|-------|
|Application|Application|
|Presentation|Application|
|Session|Application|
|Transport|Transport|
|Network|Internet|
|Data Link|Link|
|Physical|Link|

<br>

Both models have different layers because of different approaches.
- Internet Protocol Suite: divides layers in terms of the scope of communication in each layer
  - Within a local network, between networks, etc.
- OSI model divides the layers in terms of the functions that each layer provides
  - Physical addressing, logical addressing and routing, encryption, compression, etc.

<br>

## Data Encapsulation

Both models — and in general most network communication models — use the idea of data encapsulation. In networking, encapsulation is hiding data from one layer by encapsulating it within a data unit of the layer below.

### Protocol Data Units

A Protocol Data Unit (PDU) is a block of data transferred over a network. PDUs are refered to different names according to the protocol or protocol layer. For example:
- At the Link/Date Link layer a PDU is known as a frame.
- At the Internet/Network layer it's known as a packet
- At the Transport layer it's known as a segment (TCP) or datagram (UDP)

But in all cases the basic concept of a PDU consits of a:
1. Header
2. Data Payload
3. Optional: a trailer or footer

Headers and (if included) trailers do the same thing: transfer the protocol's metadata about the PDU. However, the exact structure of the header or trailer varies protocol to protocol.

Data payloads are the data we want to transport over the network using a specific protocol at a particular network layer.

What seems to be happening across protocols and how does it relate to encapsulation?

The entire PDU (including the header and trailer) at one level is set as the data payload for a protocol at the layer below. An HTTP Request at the Application layer could be set as the payload for a TCP segment — which has its own header. That TCP Segment's PDU (including its header) then becomes the payload for the layer below, and so forth.

The key benefit is that it separates the data at each layer by encapsulating the data of each protocol. Thus, a protocol at one layer doesn't need to know anything about a protocol in another or how it's implemented for the protocols to interact. The protocol at the layer below just knows that it needs to encapsulate some data from the layer above and provide that result to the layer below it.

This separation of layers provides some abstration that allows us to use different protocols at certain layers without worrying. E.g., in the Application layer we could use SMTP for an email client, HTTP for a browser, and FTP for file transfers but they could all use TCP at the Transport layer to transfer application layer data.

# Physical Network

To recap:

- Protocols are a system of rules in network communications
- Group of protocols work within a layered system where protocols at a layer below provided services to those at a layer above
- Data is encapsulated into a Protocol Data Unit, which separates the data of protocols that are at different layers

These ideas are abstractions. If we zoom in, at the most basic layer there's a physical system that allows this to happen. This physical network is made up of networked devices (routers, switches, hubs), cables, and wires. The physical network includes things we can't see but are governed by the laws of physics and rules, like radio waves used in wireless networks.

These physical laws and rules determine how data is transported from one place to another in a physical sense. There are real-world limitations: how fast electrical signal or light can travel, or the distance a radio wave can reach. These physical limiations impact the protocols because they've trickled down as design decisions to take in mind these limitations.

## Bits and signals

The OSI (Open Systems Interconnection) model defines a physical layer as the lowest in its model. The Internet Protocol Suite doesn't explicitly cover physical interfaces but it does cover some in the Link layer.

A (rough) approximation to how Open System Interconnection and TCP/IP models map to each other.

|OSI|TCP/IP|
|--------------|-------|
|Application|Application|
|Presentation|Application|
|Session|Application|
|Transport|Transport|
|Network|Internet|
|Data Link|Link|
|Physical|Link|

At this level the functionality refers to the transfer of bits (binary data). These bits are converted into signals depending on how it's transported: electrical signals, light signals, or radio waves.

[Khan Academy video](https://www.khanacademy.org/partner-content/code-org/internet-works/v/the-internet-wires-cables-and-wifi)

### Wires, cables and wifi

Internet ships binary information. A bit is any pair of opposites — typically a 1 (on) or 0 (off). A bit struck together is a byte. Everything is sent around as bits. A bit can be represented in many forms, such as the light that bounces down a fiber optic cable.

|Medium      |Pro           |Con        |
|------------|--------------|-----------|
|Electricity |Cheap         |Signal loss|
|Light       |No signal loss|Expensive  |
|Radio/Waves |Totally mobile|Short range|

<br>

Signals weaken with distance and time.

We send bits by electricity, light and waves.

Bandwidth: maximum transmission capacity of a device.

Latency: time it takes for a bit to travel from the source to destination.

Fiber optic cable: a thread of light engineered to reflect light. Depending on the bounce angle we can send multiple bits simultaneously. Copper cables are a substitute.

Wireless: translate 1 and 0s into radio waves of different frequences.

## Physical network characteristics

We need to think of latency and bandwidth.

Latency is the **measure of time** it takes to get data **from one point of the network to another**.

If there's a single car lane 10KM long and cars can go up to 60KM/H, the latency would be 10 minutes because at the maximum speed it'll take a car that time.

Bandwidth is the **amount of data** that can be **sent in a specific unit of time** (usually 1 second).

In that single car lane the bandwidth is limited to one car. If we add 1 more lane we increase the bandwidth by 1 car, but the latency stays the same. Thus, just increasing a network's bandwidth doesn't necessarily improve the speed of the network.

### Elements of Latency

Latency is a measure of delay. The difference in time between two points is the latency. But the overall latency depends on different types of delay.

- Propagation delay
  - The amount of time it takes for a message to travel from the sender to the receiver
  - Calculated as ratio between distance and time (e.g. 60KM/H => 1KM/M * 10KM => 10 minutes)
- Transmission delay
  - The time taken from pushing data form one link to another
  - Data won't be transported through a network in a single physical device (link) — it'll use many and will need to push the data between them
    - Mental map: a network is made from many individual links in the overall system
  - Driving analogy: the time it takes to enter a highway or turn around a corner
- Processing delay
  - When data travel from one link to another in the physical network it is processed in various ways
  - Driving analogy: if you had to stop and pay before changing highways
- Queuing delay
  - Network devices like routers can only process a certain amount of information at the same time
  - It places data it can't handle at the moment in the que or buffer (i.e., it queues or buffers the data)
  - Queuing delay is the amount of time data is queued
  - Driving analogy: time waiting *for your turn* to pay at the checkpoint before entering a highway

The total latency between 2 points (e.g. between a client and server) is the sum of all the delays above. It's usually given in miliseconds (ms).

Other latency terms we might encounter include:
- Last-mile latency
  - At the network edge closest to the end points is where there are more frequent and shorter hops
    - Data is directed down the network hierarchies into the appropriate sub-network
    - Network edge is the "entry point" into a network like a LAN
    - Last-mile latency refers to the latency at this last mile: mostly from getting the network signal from your ISP's network to your home or office network
- Round-trip Time (RTT)
  - Latency calculation that takes into account how long it takes for a signal to be sent and a response to be received

Exploration: viewing the network hops (journeys between routers that process and forward data to the next node on the network) from my CLI to Google using `traceroute`
```
jadlp@Joses-MacBook-Air ls170 % traceroute google.com
traceroute to google.com (172.217.168.174), 64 hops max, 52 byte packets
 1  router.movistar (192.168.8.1)  7.685 ms  5.188 ms  2.520 ms
 2  * * *
 3  10.243.241.161 (10.243.241.161)  56.455 ms  38.529 ms  28.435 ms
 4  154.red-81-46-76.customer.static.ccgg.telefonica.net (81.46.76.154)  72.996 ms
    153.red-81-46-76.customer.static.ccgg.telefonica.net (81.46.76.153)  46.945 ms  81.329 ms
 5  53.red-5-205-25.dynamicip.rima-tde.net (5.205.25.53)  64.519 ms  44.929 ms *
 6  1.red-80-58-106.staticip.rima-tde.net (80.58.106.1)  60.718 ms  48.124 ms *
 7  * 176.52.253.97 (176.52.253.97)  61.260 ms  41.796 ms
 8  72.14.211.154 (72.14.211.154)  59.133 ms
    176.52.253.102 (176.52.253.102)  47.032 ms
    google-be4-grcmadno1.net.telefonicaglobalsolutions.com (213.140.50.43)  46.650 ms
 9  * * *
10  142.250.62.204 (142.250.62.204)  65.775 ms
    74.125.253.198 (74.125.253.198)  47.304 ms
    142.250.46.166 (142.250.46.166)  40.535 ms
11  74.125.253.201 (74.125.253.201)  47.772 ms
    mad07s10-in-f14.1e100.net (172.217.168.174)  50.796 ms
    74.125.253.203 (74.125.253.203)  39.819 ms
```

### Bandwidth

Bandwidth changes throughout a network. The bandwidth of your home router is much smalled than the one that travels in the core physical network.

Bandwidth bottleneck is the point at which bandwidth changes from high to low.

Though low bandwidth can be an issue we'll see that latency tends to be more problematic in a networked application.

<br>

# Link/Data Link Layer

Just having the physical devices doesn't mean they'll communicate and exchange data because they wouldn't know how to communicate — they need rules.

One of the most important is identifying the device to which we want to send data. Within the Open Systems Interconnection model Layer 2, the Data Link layer, comes between the Physical (1) and Network (3) layer. Within the Internet Protocol Suite the Link layer is layer 1 since this model doesn't specify a physical network layer.

At the Data Link/Link layer the most used protocol is the Ethernet protocol. Ethernet cables are designed according to a technical specification that includes the Ethernet protocol that governs this layer. This is what allows them to connect various devices, e.g. computers, switches and routers.

Ethernet has 2 critical aspects: framing and addressing.

## Ethernet Frames

Ethernet Frames are a Protocol Data Unit that encapsulates the data from the Internet/Network layer above. This is the lowest level at which encapsulation takes place because at the physical layer data is a stream of bits without a logical structure. In contrast, an ethernet frame stores its binary data in a logical structure. Though it's binary data, the frame defines which is the data payload and which is the metadata used to process the frame's transport.

An Ethernet-compliant network device can identify parts of the frame because different fields of data have i) specific lengths in bytes and ii) are stored in a set order.

![Image](https://da77jsbdz4r05.cloudfront.net/images/ls170/data-link-layer-frame-structure.png)

- Preamble and Start Frame Delimiter (SFD):
  - Are sent just prior to the frame (isn't on it) to notify the receiving device it should expect a frame and then identify the start point of that data
  - The preamble is seven bytes (56 bits) and the SFD is one byte (eight bits)
  - It uses a repeating pattern which enables it to be recognized by the receiving device.
- **Destination and Source MAC Address**
  - Both are six bytes (48 bits) long
  - Source address: the device that created the frame
  - Destination address: the device for which the data is intended
- Length
  - Indicates the size of the data payload
  - 2 bytes (16 bits) length
- DSAP, SSAP, Control
  - Each are one byte (8 bits) in length
  - DSAP and SSAP: identify the network protocol used for the data payload
  - Control: provides information about the communication mode for the frame to facilitate flow control
- **Data payload**
  - Can be between 42 and 1497 bytes
  - Contains data for the entire PDU from the layer above
- Frame Check Sequence (FCS)
  - 4 bytes (32 bits) long
  - A checksum generated by the device that creates the frame
    - Calculated from the frame data using a cyclic redundancy check
    - The receiving devices uses the same algorithm to generate a FCS and compare it to the FCS sent by the frame
      - If the checksum doesn't match: the frame is dropped
        - Ethernet doesn't retransmit dropped frames — it's the responsability of higher level protocols to retransmit lost data if it's requried by them

Note that there are multiple Ethernet standards. The one described above belongs to the most popular one — IEEE 802.3 Ethernet Standard. Other standards have different naming strictures, but the key idea is to focus on the Data Payload being used to encapsulate the layer above and the MAC Addresses being used to direct the frame between network devices. These 2 are found in all Ethernet standards.

## MAC Addresses

At the most basic instance of a network — 2 devices connected to each other — we don't need any kind of identification. This is because the recipient can assume the message is intended for it as there aren't other possible recipients.

Let's say we're using a network hub to connect several computers. A hub is a network hardware that replicates a message and forwards it to all the devices on the network. This works if you want to broadcast a message to all connected devices. When we want to send messages to specific devices we need addressing.

Every networked-enabled devices is assigned a unique MAC Address when it's manufactured. It's also referred as the physical or burned-in address because it's linked to a specific physical device and rarely changes. A MAC Address is formatted as a sequence of six pairs of hexadecimal numbers like `00:40:96:9d:68:0a`, where different ranges of addresses are assigned to different network hardware manufacturers.

When a device sends a message to a hub, the hub distributes it to all connected devices. But with specific MAC Addresses the receiving devices will discard the frames if their MAC Addresses don't match the ones in the frame. THey will accept the frame only if the MAC Addresses match.

Since it's inefficient to send frames to every device when it isn't intended for all of them, most modern networks use switches. A switch forms a network by connecting to it devices but unlike a hub it uses the destination address to direct a frame only to the intended recipients. It's able to do this by storing a switch port with a list of MAC Addresses in a MAC Address Table. A MAC Address table might look like:

|Switch Port|MAC Address|
|-|-|
|1|00:40:96:9d:68:0a|
|2|00:A0:C9:14:C8:29|
|3|D8:D3:85:EB:12:E3|
|4|00:1B:44:11:3A:B7|

MAC Addressing works well for small networks that can store all addressess in a MAC Address Table. But we can't practically conduct Inter-Network Communication using only MAC Addresses because of scale. This is prevented by 2 characteristics of MAC Addresses:
1. Addresses are physical rather than logical, and tied to a specific device
2. Flat rather than hierarchical: a single sequence of values that can't be broken down

However, IP provides a system of rules that allows us to build a network of networks and bypass MAC Address' limitations.

# Internet/Network Layer

In the Open Systems Interconnection model Network is layer 3 and in the Internet Protocol Suite model Internet is layer 2 (bottom to top).

A (rough) approximation to how Open System Interconnection and TCP/IP models map to each other.

|OSI|TCP/IP|
|--------------|-------|
|Application|Application|
|Presentation|Application|
|Session|Application|
|Transport|Transport|
|Network|Internet|
|Data Link|Link|
|Physical|Link|

In both models the primary function of protocols at this layer is to facilitate communication between hosts (computers) in different networks.

The predominant protocol for inter-network communication at this layer is IP. There are 2 versions in current use: IPv4 and IPv6. The primary features of both are the same:
1. Routing capability via IP addressing
2. Encapsulation of data into packets

## Data Packets

The PDU in the IP Protocol is referred to as a packet. A packet has a data payload and header.

As with Ethernet frames, a packet payload is the PDU from the layer above (the transport layer, usually a TCP segment or UDP datagram). As with the Ethernet Frames, IP packets are sent as bits and the header metadata is split into logical fields determined by a set size and order.

![](https://da77jsbdz4r05.cloudfront.net/images/ls170/network-layer-ip-packet-structure.png)

Some of the more important fields in a packet header include:
- Version: IP version (IPv4 or IPv6)
- ID, Flags, Fragment Offset: these relate to fragmentation
  - If the Transport layer PDU is too large it can be broken up into fragments and put back together by the recipient because of these fields
- TTL (Time to Live): the maximum number of hops a packet can take before being dropped
  - After each hip, the router that processes and forwards the packet will decrease TTL by 1
  - Why: it prevents packets that don't reach their destination from hopping endlessly around the network
- Protocol: the data payload's protocol (ie, the protocol above IP)
- Checksum: an error checking value generated by an algorithm
  - The destination device generates a value with the same algorithm
    - If it matches, the recipient accepts the packet
    - If it doesn't, the packet is dropped by the recipient
      - Note: as with Ethernet, IP doesn't retransmit dropped packets
        - Above layers need to handle this
- Source Address: 32-bit IP address of the packet source (sender)
- Destination Address: 32-bit IP address of the packet destination (intended recipient)

## IP Addresses (IPv4)

Unlike MAC Addresses, IP Addresses are logical. They are not tied to a specific device but are assigned as required to devices as they join a network. A device is assigned an IP address from a range of addresses available to the local network the device is connected to. The range is defined by a network hierarchy that is split into logical subnetworks, each with its defined IP Addresses available to it.

IPv4 addresses are 32bits long and divided into 4 sections of 8 bits each. When converted to a decimal number each sections provides a range of numbers between 0 and 255, like `109.156.106.57`.

For example, the range of a local network could be between `109.156.106.0` to `109.156.106.255`.
- Network address: the lowest value (`109.156.106.0`)
- Boradcast address: the highest value (`109.156.106.255`)
- IP Addresses of individual devices: all variations between the network and broadcast address (`109.156.106.1` to `109.156.106.254`)

The network address creates a hierarchical structure. When a router wants to forward an IP packer to an address it only needs to keep a record of which router controls the segment with that network address. This implies routers don't need to keep a record of every device.

Splitting a network into parts is called sub-netting. Subnets can be split into smaller subnest with more tiers in the hierarchy.

![Khan Academy image on IP and IP Addresses](https://da77jsbdz4r05.cloudfront.net/images/ls170/network-layer-packet-routed-via-ip-to-subnet.png)

## Routing and Routing Tables

All routers on the network store a local routing table. When a router receives an IP packet it looks at the destination IP address and matches it against a lst of network addresses in its routing table. These network addresses define a range or addresses within a subnet.

[Khan Academy video](https://www.khanacademy.org/partner-content/code-org/internet-works/v/the-internet-packet-routers-and-reliability)

### Packets routers and reliability

Data travels on the internet indirectly. The IP Protocol sends information as IP Packets. If a piece of information being sent is too large, it's broken down into multiple packets and sent independently.

IP Packets travel variable routes that depend on the bandwidth of the various paths in the network. Each packet travels independently and can arrive at the destination at different times and in any order.

Packets take the cheapest route to an IP Address. Cheapest is based on time, politics and company relationships. Packets are directed via routers.

Multiple IP Packets that make up a file are then reassembled at the destination through the Transmission Control Protocol (TCP). This verifies that all packets have arrived, requests missing packats (if applicable), and reassemble the full file. If the packets are incomplete or sent to the wrong IP Address, they're dropped after it hopes more times than permitted. The IP doesn't handle what happens in those cases — it just drops it and higher level protocols deal with retransmitting dropped packets.

The more routers there are in the network, the more resilient it is. Thus, it operates on the principles of redundancy and resilience.

## IP Addresses (IPv6)

In IPv4 there's a maximum of 4.3b addresses, which will eventually be depleted. The Internet Engineering Task Force (IETF) has been working since the late 90s on a new IP called IPv6 which uses 128-but addresses (eight 17-bit blocks) — increasing the theoretical number of possible IP addresses to 340 undecillion (340 billion billion billion).

Other differences include a different header structure for the packet and a lack of error checking (it leaves it to the Link layer checksum).

## Networked Applications

## IP Addresses and DNS

Computers connect to wifi at home, and that wifi connects to an Internet Service Provider (ISP) that connects you to billions of devices through thousand of interconnected networks.

Internet is a design philosophy and architecture expressed as protocols. Protocols have allows the internet to absorb new technologies. All devices in the internet have a unique IP address. This is equivalent to a mailing address of a home.

Visiting a website is essentially a computer sending a message to the server at the recipient's IP address, and attaching the sender's IP address so that it can respond.

DNS associates URLs with IP Addresses. DNS servers are connected into a distributed heirarchy and divided into zones, splitting responsability for major domains like .com, .net, .org, etc. A hacker can hack a DNS server and have the server point to the wrong IP Address.