The browser is the interface or window through which we interact with the WWW.

Under the browser's hood there's a series of files that the browser renders on the screen: HTML, CSS, Javascript, images, GIFs, and others. These files are what allow the browser to display a page. These files went from the server to the client (your browser). They travelled through an application protocol called HTTP — which is why URLs starts with HTTP.

Hyper Text Transfer Protocol (HTTP) was invented by Tim Berners-Lee in the 80s. It is a protocol — a system of rules — that links applications and the transfrt of **hypertext documents**. Thus, it's a message format for machines to communicate with each other.

HTTP follows a request-response cycle. It sends strings in a standard format following a 2 part process:
1. The client sends a **request** to a server
2. Waits for the **response** of the server

[Note: what's the definition of a protocol?]

Though it originally only sent HTML pages, it quickly grew in complexity:
- HTTP/0.9 (1991): first document version of HTML
- HTTP/1.0 (1992): extended to CSS documents, videos, images, and scripts
- HTTP/1.1 (1995): allows you to reused established connections for subsequent requests, among other features
- HTTP/1.1 (1999): more improvements to HTTP/1.1
- HTTP/2 (2015): introduced
- HTTP/3 (2020): in the process of being introduced

# How does the internet work?

The internet is built on millions of interconnected networks that allow the devices that access it to communicate with one another. All devices that participate in the network are provided unique labels called **Internet Protocol Address** (IP Address). This is analogous to a computer's phone number on the internet. THe Internet Service Provider (ISP) provides each device with a public IP address.

An IP address acts as the device or server's identifier and looks like:
```
jadlp@Joses-MacBook-Air http_book % ipconfig getifaddr en0
192.168.8.100
```

**Port numbers** add more detail about how to communicate. A device or server can have hundreds or thousands of ports. It'd use each port for a different communication purpose. Port numbers can be appended to IP addresses, such as:

```
192.168.8.100:1234 # Port number is 1234
```

# DNS

The Domain Name System (DNS) does the mapping between a public URL to an IP address. It keeps track of domain names and their corresponding IP addresses. A DNS is a distributed database that translates a domain name like `http://www.google.com` to an IP address like `197.251.230.45` that can be used to make server requests.

```
jadlp@Joses-MacBook-Air http_book % nslookup www.google.com
Server:		192.168.8.1
Address:	192.168.8.1#53

Non-authoritative answer:
Name:	www.google.com
Address: 172.217.17.4 # Google's IP Addess
```

DNS databases are stored in computers called DNS servers. No single DNS server contains the entire database that maps domain names to IP Addresses. DNS servers are structured in a large hierarchical network.

If a DNS server does not have the requested domain name it forwards it to another server up the heirarchy. The address will be eventually found in the DNS database of a DNS server and the corresponding IP Address will be used to receive the client's request.

For example, if I were to input `http://www.google.com` the process until I see it in my browser would be:
1. Enter the URL into the browser's address bar
2. The browser creates an HTTP request that is packaged and sent to the device's network interface
  - An HTTP request is some text sent to an IP Address
3. The device will check in its DNS cache if it has a record of the IP Address
  - If it does, it uses the cached IP Address
  - Otherwise, a DNS request will be made to the Domain Name System — returning the IP Address
4. The packaged up HTTP request goes to the server that matches the IP Address provided
5. The remote server accepts the request and returns a response that gets sent to your network interface — and through it to your browser
6. The browser displays the response as a web page

# Clients and Servers

The most common client is a web browser. Web browsers issue HTTP requests and process the HTTP response. Yet there are other tools and apps that can issue HTTP requests besides browsers.

Servers are a remote computer that hold the content that you're requesting via the HTTP. Servers are devices that can handle inbound requests and issue a response.

## Resources

Resources include: images, videos, web pages, and other files. These can include software that allows you to play a video game or trade stock.

## Statelessness

A protocol is stateless when each request/response pair is designed to be independent of the previous one.

HTTP is a stateless protocol, which implies that:
- The server does not need to store information (state) between request/response cycles
  - Implications
    - Resilience: When a request breaks en route to the server the system doesn't have to do any cleanup
    - However: it's difficult to simulate a stateful experience in webapps
      - E.g. Facebook
        - Log-in: one request/response cycle
        - Click on image: another request/response cycle
        - But if it's stateless, how does FB know it should keep you logged in?
