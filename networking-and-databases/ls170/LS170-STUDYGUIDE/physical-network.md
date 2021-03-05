The 'physical network' are the tangible pieces of the network, such as the networked devices, cables, wires, radio waves, fiber optic cables, etc.

The physical layer is the bottommost layer of the OSI model, and is partially included in the Link layer in the Internet Protocol Suite.

There are three means of transmission:
- Fiber optic cables ()
- Radio waves
- Electrical signals
- Light

# What are the limitations of the physical network?
The perforamnce of the physical network is characterized by how fast data can travel (latency), which is measured by how long it takes for data to travel from point A to point B across networks,  and the amount of data it can support at one time (bandwidth). There are other limitations like how far a radio wave can travel.


# Describe the concepts of latency and bandwidth and how they relate. How do they limit the physical network?

While low bandwidth can be a limitation on the performance of a networked application, generally latency is a more serious limitation.

Bandwidth varies across the network, and is measured as the lowest amount the connection receives at a particular point in the overall connection. Sometimes the bandwidth drops from being high to low, which is called a ***bandwidth bottleneck***.

In simple terms, latency is how fast data can move across networks from a source to a destination, but there is more to latency in terms of types of delays. 

|Delay type|Description|
|------|------|
|Propagation delay|The ratio between distance and speed|
|Transmission delay|The amount of time it takes to push data onto a 'link' as it travels to the destination|
|Processing delay|The amount of time it takes to process the data|
|Queuing delay|The amount of time that data is waiting in a queue to be processed when it is buffered/waiting

> The total latency between two points, such as a client and a server, is the sum of all the delays above. This value is usually given in milliseconds (ms).

> **Round-trip Time (RTT)**: A latency calculation often used in networking is Round-trip Time (RTT). This is the length of time for a signal to be sent, added to the length of time for an acknowledgement or response to be received.


> **Last-mile latency**: A lot of the delays described above can take place within the parts of the network which are closest to the end points. This is often referred to as 'last-mile latency' and relates to the delays involved in getting the network signal from your ISP's network to your home or office network. The 'hops' within the core part of the network are longer with less interruptions for transmission, processing, and queuing. At the network edge, there are more frequent and shorter hops as the data is directed down the network hierarchy to the appropriate sub-network. You can think of the network edge as the 'entry point' into a network like a home or corporate LAN.



Program to view network hops:
`traceroute google.com`

> `traceroute` is a utility for displaying the route and latency of a path across a network. Running the command should return a list of hops taken for the test data to get from your PC or laptop to the Google server. The values indicated here are the Round-Trip Time (RTT) for each hop.