Network Reliability

A major characteristic of the communication protocols that are primarily used to provide the functionality for the lower layers in our network system is that they are inherently unreliable. We've seen that protocols such as Ethernet and the Internet Protocol include checksum data as part of their header or trailer so that the data transported as frames and packets can be tested to ensure it hasn't become corrupt during its journey. If the data is corrupt however, these protocols simply discard it (dropping the frame or packet); there is no provision within these protocols for enabling the replacement of lost data. The possibility of losing data and it not being replaced means that the network up to and including the Internet Protocol is effectively an unreliable communication channel.

As developers and software engineers, what we often need is a reliable communication channel over which to send our data. Many of the applications that we build depend on reliable data transfer. A web page wouldn't render properly without important parts of the markup, and an email might not make sense if some of the content was missing. Since at the lower levels of our network we don't have a reliable communication channel, the question then becomes: how can we transfer data reliably over an unreliable channel?

What we need to do is develop a system of rules, or a protocol, to ensure that all the data that is sent is received at the other end and in the correct order. What would such a system of rules look like?

Building a Reliable Protocol

If we wanted to build a set of rules that added reliability to our communications, how would we do that? One way would be to start with the initial problem -- that individual messages can become corrupt or lost -- and build our set of rules step by step from there.

Version 1

Problem: Messages can become corrupt or lost, how do you ensure the message has been successfully received?

Solution: Use an acknowledgement message

Rules:

Sender sends one message at a time
If message received, receiver sends an acknowledgement
When acknowledgement is received, sender sends next message
Diagram showing message > ack > next message sequence

This seems like a pretty good solution, but there's a major flaw with it. There are certain situations in which the sender will never receive an acknowledgement:

The recipient never receives the message and so doesn't send an acknowledgement
The recipient receives the message and sends an acknowledgement, but the acknowledgement becomes corrupt or lost
If sender doesn't receive the acknowledgement that a message was received they will never send the next message, breaking the system. This is clearly a huge problem for our protocol. The next version of our protocol aims to solve that issue.

Version 2

Problem: what if the acknowledgement is not received?

Solution: re-send the message if acknowledgement not received within a certain time-frame.

Rules:

Sender sends one message at a time, and sets a timeout
If message received, receiver sends an acknowledgement
When acknowledgement is received, sender sends next message
If acknowledgement not received before the timeout expires, sender assumes either the message or the acknowledgement went missing and sends the same message again
Diagram showing message > ack > next message sequence with timeout and retransmission

This would appear to solve our problem. By using this timeout and retransmission system, we can be sure that the recipient will always receive the message even if it means we may have to send it more than once.

Solving this problem has however introduced a separate problem into our system: duplication. Imagine the following scenarios:

The receiver receives the message and sends an acknowledgement, but the acknowledgement becomes corrupt or lost
The receiver receives the message and sends an acknowledgement, but the acknowledgement is delayed and the sender doesn't receive it before the timeout expires
In both of these situations, the sender would send a message that the receiver has already received. How would the receiver know that the message is a duplicate? Let's try and solve this problem in our next version.

Version 3

Problem: the message is received but acknowledgement is not received (or not in time), resulting in a duplicate message.

Solution: add sequence numbers to the messages.

Rules:

Sender sends one message at a time, with a sequence number, and sets a timeout
If message received, receiver sends an acknowledgement which uses the sequence number of the message to indicate which message was received
When acknowledgement is received, sender sends next message in the sequence
If acknowledgement is not received before the timeout expires, sender assumes either the message or the acknowledgement went missing and sends the same message again with the same sequence number
If the recipient receives a message with a duplicate sequence number it assumes the sender never received the acknowledgement and so sends another acknowledgement for that sequence number and discards the duplicate
Diagram showing message > ack > next message sequence with sequence number acknowledgement

Version 3 of our protocol covers the fundamental elements required for reliable data transfer:

In order delivery: data is received in the order that it was sent
Error detection: corrupt data is identified using a checksum
Handling data loss: missing data is retransmitted based on acknowledgements and timeouts
Handling duplication: duplicate data is eliminated through the use of sequence numbers
Our protocol as it stands is reliable. Unfortunately, it's not very efficient. One of the main features of our protocol is that each message is sent one at a time, and an acknowledgement is received before the next message is sent. This type of protocol is known as a Stop-and-Wait protocol. It's the 'Wait' part that's the problem here. Within our system, much of the time is spent just waiting for an acknowledgement. This is not an efficient use of bandwidth.

Pipelining for Performance

To improve the throughput of our protocol, we could send multiple messages one after the other without waiting for acknowledgements. You might be wondering how that impacts the reliability. Well, the receiver still sends acknowledgements, and retransmission can still occur, so our system is still reliable. The difference is that multiple messages are being transferred at any one time. This kind of approach is referred to as 'pipelining'.

Graphic illustrating the concept of Stop-and-wait vs pipelining

There are different ways of implementing this pipelined approach, such as Go-back-N and Selective Repeat. The exact differences between these implementations aren't too important. With both systems, the sender will implement a 'window' representing the maximum number of messages that can be in the 'pipeline' at any one time, once it has received the appropriate acknowledgements for the messages in the window, it moves the window on.

Diagram illustrating the concept of windowing

This interactive simulation provides a clearer illustration of how this process actually works.

The advantage of this pipelined approach is its more efficient use of available bandwidth. Instead of wasting lots of time just waiting for acknowledgements, more time is spent actually transmitting data.

Finding a balance between reliability and performance is a major part of the implementation of the Transmission Control Protocol (TCP). We'll look at this protocol in more detail in the next assignment.