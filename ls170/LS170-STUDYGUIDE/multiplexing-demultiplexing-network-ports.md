When we use the Internet Protocol, the packets create a communication channel between hosts using the destination and source IP address headers on the PDU packet. 

That can be happening for multiple applications or processes simultaneously. **Multiplexing** is the process of sharing a single communication channel for transmission of multiple signals. 

Each application or process on the host is a distinct ***channel*** for communication on a host machine. For example, if we are using Slack and Spotify at the same time, those are distinct channels. **Multiplexing** involves taking multiple signals and combining them into one signal for transmission over a single channel.

In the Transport Layer of the network communication model, multiplexing is possible due to **network ports**.

"The source and destination port numbers are included in the Protocol Data Units (PDU) for the transport layer."




> The purpose of multiplexing is to enable signals to be transmitted more efficiently over a given communication channel, thereby decreasing transmission costs.


> If there are multiple signals to share one medium, then the medium must be divided in such a way that each signal is given some portion of the available bandwidth
> When multiple signals share the common medium, there is a possibility of collision. Multiplexing concept is used to avoid such collision.



> Transport layer gathers chunks of data it receives from different sockets and encapsulate them with transport headers. Passing these resulting segments to the network layer is called multiplexing.

> The reverse process which is delivering data to the correct socket by the transport layer is called demultiplexing. But this still doesn’t explain how the transport layer identifies the correct socket. Port numbers are the ones that do the trick.


> Data from the application layer is encapsulated as the data payload in this PDU, and the source and destination port numbers within the PDU can be used to direct that data to specific processes on a host. The entire PDU is then encapsulated as the data payload in an IP packet. The IP addresses in the packet header can be used to direct data from one host to another. The IP address and the port number together are what enables end-to-end communication between specific applications on different machines. The combination of IP address and port number information can be thought of as defining a communication end-point. This communication end-point is generally referred to as a socket. We'll talk more about sockets later, but for now you can just think of them as the combination of IP address and port number, for example 216.3.128.12:8080.

The concept of multiplexing can be applied more broadly

- send and receive data simultaneously 

- Each application or process on the host is a distinct ***channel*** for communication on a host machine.

- example: "send an email, listen to Spotify, load a web page in the browser, while using Slack."