We are hiding the data from one layer by encapsulating it within a data unit of the layer beneath it. This is done via Protocol Data Units (PDU), which is a block of data that is transfered over a network. The protocols each have their own name for the PDU of the layer. 

Names for PDU:

Transport Layer: ***segment*** (TCP), ***datagram*** (UDP)
Data/Link Layer: ***frame***
Internet/Network Layer: ***packet***

PDU Contents minimum:
- Header (Protocol-specific metadata)
- Data payload (The data that we want to transport over the network at a particular network layer)
- Footer/trailer

> The data payload is the key to the way encapsulation is implemented. The entire PDU from a protocol at one layer is set as the data payload for a protocol at the layer below. For example, a HTTP Request at the Application layer could be set as the payload for a TCP segment at the transport layer.


> One concept used by both models, and in fact by most network communication models, is the idea of data encapsulation. You will already have encountered the term encapsulation in the context of programming, where it means hiding the internal representation of an object and preventing it from being accessed from outside the object.

> The idea is similar in network models. Here we are essentially hiding data from one layer by encapsulating it within a data unit of the layer below. That might be a slightly difficult concept to grasp at first, so let's break it down.