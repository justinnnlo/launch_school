# The Internet

In plain words, the Internet is a 'network of networks' that all kinds of computers and devices, from laptops to smart refrigerators, can connect to. 

It makes use of IP addesses and ports for end-to-end communication across the network.

There are several 'layers' we use to abstract away the mechanisms of the internet to think about how data is transported. In the Internet Protocol Suite model, there are 4 layers: the link layer, network layer, transport layer, and application layer. In the OSI model, there are 7 layers, adding in the physical layer, and the session and presentation data. 

The lower layers are media layers that are concerned with translating data into bits for movement across the physical network, and with logical addressing and wayfinding.

The upper layers are concerend with end-to-end connections, reliability, and protocols around requesting and responding with resources across different processes. Data is encapsulated into frames, packets, segments, and messages across the layers, following rules (protocols) to ultimately send data across a physical medium. 

Overall, reliability is engineered into the internet. The lower layers of the Internet Protocol Suite and OSI network communication models are inherently unreliable. For example, the Ethernet and Internet Protocols use checksum to test for data corruption, but they discard the frame/packet if there is an issue and don’t have their own system for replacing lost data. For this whole internet thing to work though, we need reliability. Network communication reliability is handled by Transport Layer protocols.

The layer we most commonly use is the application layer in the form of HTTP requests. THe HTTP request-response protocol provides specific rules for writing requests and responses so the Client and Server can both understand the messages. 

# What is the Internet Protocol and what does it do?

> The Internet Protocol (IP) is a key part of the functionality of the internet. 

# What is the internet and how it work?

In plain words, the Internet is a 'network of networks' that all kinds of computers and devices, from laptops to smart refrigerators, can connect to. 

It makes use of IP addesses and ports for requests and responses. 


# What is a network?

Simple version of a network: two computers connected via LAN cable with configured network settings to form a distinct network.

It's not very common to find two computers simply connected to each other via a Local Area Network (LAN) cable, but what you might see is a network of computers at an office connected via a hub or switch, which are both types of network bridging devices, or a home network with a central wireless hub or switch to which devices can connect wirelessly (via WLAN).

The switch or hub is key to forming a particular local network, because it is what connects the devices. 

So how do we get access to the internet? Routers, network devices that can route network traffic to other networks, enable communication between networks. (Now we are getting closer to understanding our 'network of networks' response to 'what is the internet' question).

Simplified, we then can depict a mesh of router to router communication, which means the networks are also connected together via those routers. 

# What types of devices can connect to the internet?
Laptops, tablets, phones, kettles, toasters, refrigerators, and more. We generally think of computers when picturing networks, but it also pertains to IoT technology. All of those devices are connected via hubs, switches, routers, and servers. They are able to communicate because they use **protocols**, which are a set of rules that govern the transmission of data. 

# Why are there so many different protocols for network communication?
There are numerous protocols for network communication because each protocol was developed to resolve a specific aspect of network communication and in different ways.


# What are the limitations of the physical network? 
file: physical-network.md

# Describe the concepts of latency and bandwidth and how they relate. How do they limit the physical network?
file: physical-network.md



# How do the lower level protocols operate?



- Understand that protocols are systems of rules

# What is an IP address and how does it relate to a port number?


- Learn that IP enables communication between devices

# How does DNS work? 📝







- Understand the client-server model of web interactions, and the role of HTTP as a protocol within that model
- Build a general picture of the network infrastructure


> Your browser is the interface or window, through which you interact with the world wide web.
