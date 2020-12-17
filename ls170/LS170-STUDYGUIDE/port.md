A port is an identifier for a process that is running on a host. Because there is generally more than one service running on a device, we need ports so we can identify where to communicate for a network communication process. While IP addresses get communication capability as far as a device, ports are the end-game for end-to-end communication. Because we have so many different services running in parallel, there are ranges for port numbers. The most common port numbers we use are 80 and 443, which are for HTTP and HTTPS. 

---



> In simple terms a port is an identifier for a specific process running on a host. This identifier is an integer in the range 0-65535. Sections of this range are reserved for specific purposes:

0-1023 are well-known ports. These are assigned to processes that provide commonly used network services. For example HTTP is port 80, FTP is port 20 and 21, SMTP is port 25, and so on.
1024-49151 are registered ports. They are assigned as requested by private entities. For example, companies such as Microsoft, IBM, and Cisco have ports assigned that they use to provide specific services. On some operating systems, ports in this range are also used for allocation as ephemeral ports on the client side.
49152-65535 are dynamic ports (sometimes known as private ports). Ports in this range cannot be registered for a specific use. They can be used for customized services or for allocation as ephemeral ports.
Services running on servers will likely have a port in the well-known range assigned to them. If you want to connect via HTTP to a web-server running on a host machine, that web-server process will likely have port 80 assigned to it. This is sometimes described as the web server listening on port 80. We'll look in a bit more detail at what that means later on.

A service running on a client machine, for example in a browser running on your laptop, won't use one of these well-known ports, but instead have an ephemeral or temporary port assigned to it by the operating system, for example 59258.

So we can use ports to identify specific services running on host machines, but how does that help us with multiplexing and demultiplexing? The answer is that the source and destination port numbers are included in the Protocol Data Units (PDU) for the transport layer. The name, and exact structure, of these PDUs varies according to the Transport Protocol used, but what they have in common is that they include these two pieces of information.

Data from the application layer is encapsulated as the data payload in this PDU, and the source and destination port numbers within the PDU can be used to direct that data to specific processes on a host. The entire PDU is then encapsulated as the data payload in an IP packet. The IP addresses in the packet header can be used to direct data from one host to another. The IP address and the port number together are what enables end-to-end communication between specific applications on different machines. The combination of IP address and port number information can be thought of as defining a communication end-point. This communication end-point is generally referred to as a socket. We'll talk more about sockets later, but for now you can just think of them as the combination of IP address and port number, for example 216.3.128.12:8080.

This concept can be a little bit tricky to grasp at first, so it might help to compare it with a concept most of you should be familiar with: the postal service. Imagine an apartment building. It has numerous apartments, but the building itself has a single street address. The postal worker delivers a bunch of mail to the building. The concierge of the building then sorts the mail and posts the individual letters to the appropriate mailbox in the foyer, each mailbox being identified by a specific apartment number.

In this context we can think of the street address of the apartment building address as the IP address and the individual apartment numbers as port numbers. Furthermore, the postal service can be thought of as the Internet Protocol, and the building concierge as a Transport layer protocol (e.g. TCP or UDP).