# IP Addresses
IP Addresses are a unique address used to locate a device on the internet.

IP Addresses are not tied to specific devices, and are assigned as required to devices to join a network. When the IP address is assigned, it is based on an available range:

- It must fall within a range of addresses that are available to that local network
- The range comes from a network hierarchy, with an overall network being split into logical subnetworks that each have a range assigned.

# IP Address Format
The format of IP Addresses is a group of 4 sets of numbers, with each set representing different aspects of some location on the internet.

> IPv4 addresses are 32 bits in length and are divided into four sections of eight bits each. When converted from binary to decimal, each of those sections provides a range of numbers between 0 and 255 (since 2 to the power of 8 equals 256). For example 109.156.106.57.

For IPv6, "A group of 8 sets of hexadecimal characters, with different adjacent combinations of those 8 sets representing different aspects of a location on the network."

## IP Address format and routing

> We won't go into what broadcast address is used for, but the network address of the range is used to identify a specific network segment. What this means is that a router that wants to forward an IP packet to any address in the entire range only needs to keep a record of which router on the network controls access to the segment with that network address. This logic is what creates the hierarchical structure, and means that routers don't need to keep records of every single device within an addressable range. [Link](https://launchschool.com/lessons/4af196b9/assignments/b222ecfb)

> This splitting of a network into parts is referred to as sub-netting. By dividing IP address ranges further, subnets can be split into smaller subnets to create even more tiers within the hierarchy.


# IPv4 IPv6
As well as a difference in address structure, IPv6 has some other differences with IPv4 such as a different header structure for the packet and a lack of error checking (it leaves this to the Link Layer checksum).


<!-- From Launch School -->
# Routing and Routing Tables
All routers on the network store a local routing table. When an IP packet is received by a router, the router examines the destination IP address and matches it against a list of network addresses in its routing table. As explained above, these network addresses define a range of addresses within a particular subnet. The matching network address will determine where in the network hierarchy the subnet exists. This will then be used to select the best route for the IP packet to travel.

This Khan Academy video provides a basic overview of packet routing.


# IPv6
The structure of IPv4 addresses means that there is a logical maximum of around 4.3 billion addresses. Due to the popularity of the internet, it is anticipated that this pool of addresses will eventually be depleted. Since the late 1990s, the Internet Engineering Task Force (IETF) have been working on a new version of the Internet Protocol called IPv6. Since IPv6 uses 128-bit addresses (eight 16-bit blocks), this increases the theoretical number of possible addresses to approximately 340 undecillion (340 billion billion billion billion).

As well as a difference in address structure, IPv6 has some other differences with IPv4 such as a different header structure for the packet and a lack of error checking (it leaves this to the Link Layer checksum).





https://launchschool.com/lessons/4af196b9/assignments/b222ecfb
Version: this indicates the version of the Internet Protocol used, e.g. IPv4
ID, Flags, Fragment Offset: these fields are related to fragmentation. If the Transport layer PDU is too large to be sent as a single packet, it can be fragmented, sent as multiple packets, and then reassembled by the recipient.
TTL: every packet has a Time to Live (TTL) value. This is to ensure that any packets which don't reach their destination for some reason aren't left to endlessly bounce around the network. The TTL indicates the maximum number of network 'hops' a packet can take before being dropped. At each hop, the router which processes and forwards the packet will decrement the TTL value by one.
Protocol: this indicates the protocol used for the Data Payload, e.g. TCP, UDP, etc.
Checksum: this is an error checking value generated via an algorithm. The destination device generates a value using the same algorithm and if it doesn't match, it drops the packet. IP doesn't manage retransmission of dropped packets. This is left to the layers above to implement.
Source Address: the 32-bit IP address of the source (sender) of the packet
Destination Address: the 32-bit IP address of the destination (intended recipient) of the packet

<!-- Fi from Launch School -->