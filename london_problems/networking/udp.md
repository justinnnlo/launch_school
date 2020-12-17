User Datagram Protocol (UDP)

In the previous assignment, we saw how TCP implements reliable data transfer through sequencing and retransmission of lost data, as well as providing mechanisms for flow control and congestion avoidance. So how does UDP implement all of those things? Well, basically, it doesn't.

The Protocol Data Unit (PDU) of UDP is known as a Datagram. Like all the PDUs we've looked at so far it encapsulates data from the layer above into a payload and then adds header information. If we examine the header of a UDP Datagram, we can see that it's really quite simple.

Diagram of a UDP datagram header, showing Source Port, Destination Port, UDP length, and Checksum fields

The header only has four fields: Source Port, Destination Port, UDP Length (the length, in bits, of the Datagram, including any encapsulated data), and a Checksum field to provide for error detection. That's it. Even the Checksum field is optional if using IPv4 at the Network layer (if using IPv6, you need to include a Checksum in the Datagram since IPv6 packets don't include one themselves).

Through the use of the Source and Destination Port numbers, UDP provides multiplexing in the same way that TCP does. Unlike TCP however, it doesn't do anything to resolve the inherent unreliability of the layers below it. In fact, it's probably easier to define UDP by what it doesn't do (particularly in comparison with TCP) than by what it does do.

It provides no guarantee of message delivery
It provides no guarantee of message delivery order
It provides no built-in congestion avoidance or flow-control mechanisms
It provides no connection state tracking, since it is a connectionless protocol
The Case for UDP

You might be wondering, if UDP is unreliable then why use it? Why not just use TCP? The advantage that UDP has over TCP is its simplicity. This simplicity provides two things to a software engineer: speed and flexibility.

UDP is a connectionless protocol. Applications using UDP at the Transport layer can just start sending data without having to wait for a connection to be established with the application process of the receiver. In addition to this, the lack of acknowledgements and retransmissions means that the actual data delivery itself is faster; once a datagram is sent it doesn't have to be sent again. Latency is less of an issue since without acknowledgements data essentially just flows one way: from sender to receiver. The lack of in-order delivery also removes the issue of Head-of-line blocking (at least at the Transport layer).

It's likely that someone building a UDP-based application will want to implement some of the services that UDP doesn't natively provide. Which services those would be, and the way they're implemented, would be up to whoever was building the application though. For example, you might want your application to have in-order delivery, but at the same time not be worried about the occasional piece of lost data. You could implement sequencing, but choose not to implement data retransmission. The specifics of which services to include are in left up to the software engineer and can be implemented at the application level, effectively using UDP as a 'base template' to build on top of.

An example of such an application would be a voice or video calling application. The occasional piece of dropped data leading to a slightly glitchy call or a few pixels of video not rendering properly is worth the trade off of the speed provided by the protocol which allows the application to work even over long distances where there is high latency. Another example would be online gaming where the occasional loss of data causing a slight glitch is more acceptable than having significant lag in the gaming experience.

While UDP provides a lot of flexibility and freedom, with that freedom comes a certain amount of responsibility. There are various best practices that should be adhered to. For example, it would be expected that your UDP-based application implements some form of congestion avoidance in order to prevent it overwhelming the network.