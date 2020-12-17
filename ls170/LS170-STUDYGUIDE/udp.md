In contrast to TCP, the User Datagram Protocol (UDP) is connectionless.

What that means is that it is a lot more simple than TCP, so it's used for services where it is okay if data is occasionally dropped as a tradeoff against high latency. For example, video calls and video games have more flexibility with UDP.

UDP just provides the basics in the UDP datagram header: source and destination port numbers, the length, and checksum. 

Programmers can still choose to implement other serivces on top of UDP, such as sequencing, to ensure data is received in order, while being okay with dropped data. 