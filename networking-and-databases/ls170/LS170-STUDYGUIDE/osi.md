
OSI (Open Systems Interconnection) is a reference model for how applications communicate over a network.


At the destination, the reverse process happens. Each layer decapsulates the receiving packets and handover the payload to the higher level layer until the message reaches the application level. One thing to keep in mind here is that, between the source and the destination, there can be many routers, link layer switches which can contain different set of layers depending on their functionality. For example, routers typically don’t have transport or application layers implemented within them.

https://searchnetworking.techtarget.com/definition/OSI

A reference model is a conceptual framework for understanding relationships. The purpose of the OSI reference model is to guide vendors and developers so the digital communication products and software programs they create can interoperate, and to facilitate a clear framework that describes the functions of a networking or telecommunication system.

Most vendors involved in telecommunications make an attempt to describe their products and services in relation to the OSI model. And although it is useful for guiding discussion and evaluation, OSI is rarely actually implemented as-is. That's because few network products or standard tools keep related functions together in well-defined layers, as is the case in the OSI model. The TCP/IP protocol suite, which defines the internet, does not map cleanly to the OSI model.

CONTENT CONTINUES BELOW
DOWNLOAD THIS FREE GUIDE

How SD-WAN Can Help Enable Digital Transformation
When embarking on digital transformation initiatives, its important to factor in WAN design to avoid poor application performance and customer dissatisfaction. In this white paper, you’ll explore the drawbacks of traditional WAN architectures and how a managed SD-WAN service can overcome some of these challenges.

Corporate E-mail Address:

I agree to TechTarget’s Terms of Use, Privacy Policy, and the transfer of my information to the United States for processing to provide me with relevant information as described in our Privacy Policy.

I agree to my information being processed by TechTarget and its Partners to contact me via phone, email, or other means regarding information relevant to my professional interests. I may unsubscribe at any time.
How the OSI model works
IT professionals use OSI to model or trace how data is sent or received over a network. This model breaks down data transmission over a series of seven layers, each of which is responsible for performing specific tasks concerning sending and receiving data.

The main concept of OSI is that the process of communication between two endpoints in a network can be divided into seven distinct groups of related functions, or layers. Each communicating user or program is on a device that can provide those seven layers of function.

In this architecture, each layer serves the layer above it and, in turn, is served by the layer below it. So, in a given message between users, there will be a flow of data down through the layers in the source computer, across the network, and then up through the layers in the receiving computer. Only the application layer, at the top of the stack, doesn’t provide services to a higher-level layer.

The seven layers of function are provided by a combination of applications, operating systems, network card device drivers and networking hardware that enable a system to transmit a signal over a network Ethernet or fiber optic cable or through Wi-Fi or other wireless protocols.

OSI communication model illustrated
TechTarget
7 layers of the OSI model
The seven Open Systems Interconnection layers are:

Layer 7: The application layer: Enables the user (human or software) to interact with the application or network whenever the user elects to read messages, transfer files or perform other network-related activities. Web browsers and other internet-connected apps, such as Outlook and Skype, use Layer 7 application protocols.

Layer 6: The presentation layer: Translates or formats data for the application layer based on the semantics or syntax that the application accepts. This layer is also able to handle the encryption and decryption that the application layer requires.

Layer 5: The session layer: Sets up, coordinates and terminates conversations between applications. Its services include authentication and reconnection after an interruption. This layer determines how long a system will wait for another application to respond. Examples of session layer protocols include X.225, AppleTalk and Zone Information Protocol (ZIP).

Layer 4: The transport layer: Is responsible for transferring data across a network and provides error-checking mechanisms and data flow controls. It determines how much data to send, where it gets sent and at what rate. The Transmission Control Protocol is the best known example of the transport layer.

Layer 3: The network layer: Primary function is to move data into and through other networks. Network layer protocols accomplish this by packaging data with correct network address information, selecting the appropriate network routes and forwarding the packaged data up the stack to the transport layer.

Layer 2: The data-link layer: The protocol layer in a program that handles the moving of data into and out of a physical link in a network. This layer handles problems that occur as a result of bit transmission errors. It ensures that the pace of the data flow doesn’t overwhelm the sending and receiving devices. This layer also permits the transmission of data to Layer 3, the network layer, where it is addressed and routed.

Layer 1: The physical layer: Transports data using electrical, mechanical or procedural interfaces. This layer is responsible for sending computer bits from one device to another along the network. It determines how physical connections to the network are set up and how bits are represented into predictable signals as they are transmitted either electrically, optically or via radio waves.