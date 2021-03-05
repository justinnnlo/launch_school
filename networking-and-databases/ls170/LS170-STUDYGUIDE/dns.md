The Domain Name System (DNS) is used to give common names to IP addresses across the internet. Instead of finding resources by typing in an IP address identifier and a port number, we type in a URL when surfing the web. The reason we are able to do this is thanks to the DNS system, which is a distributed network of servers that store the domain name to the IP address mapping. 

When you type in the URL, a DNS request is made to obtain the IP address. First, the request is made to a resolver called the Root Server that will know DNS information about Top Level Domains (.com, .url. etc) and gets the IP address of the domain's "name server", which will be able to respond with the IP address of the full domain (i.e. youtube.com). The resolver then tells the browser what the IP address is, so the browser can make an HTTP request to the server.

Also, your device can already have a record of the IP address for the domain name that is cached from a previous visit, which it can use instead of making a request to the DNS servers. 


--- 


https://launchschool.com/books/http/read/background#briefhistory

https://launchschool.com/books/http/read/background#howtheinternetworks

The Internet consists of millions of interconnected networks that allow all sorts of computers and devices to communicate with each other. By convention, all devices that participate in a network are provided unique labels. The general term for this type of label is an Internet Protocol Address or IP Address and is similar to a computer's phone number on the Internet. Port numbers add more detail about how to communicate (think of company phone extensions). IP Addresses are represented as:

Copy Code
192.168.0.1
When a port number is needed, the address is specified as:

Copy Code
192.168.0.1:1234
where the IP Address is 192.168.0.1 and the port number is 1234. An IP Address acts as the identifier for a device or server, and can contain hundreds or thousands of ports, each used for a different communication purpose to that device or server.

When it comes to the wider Internet, effective communication begins when each device has a public IP address provided by an Internet Service Provider. But what about an address like http://www.google.com? How does your computer know what IP address it's mapped to? When we wish to connect to Google's main page, we do not type in the IP Address, we type in its URL.

DNS
This mapping from URL to IP address is handled by the Domain Name System or DNS. DNS is a distributed database which translates domain names like www.google.com to an IP address, so that the IP address can then be used to make a request to the server. Stated differently, it keeps track of domain names and their corresponding IP addresses on the Internet. So an address like www.google.com might be resolved to an IP address 197.251.230.45.

By the way, you can also get to Google's main page by typing the IP address into your browser's address bar. However, most people want to use a user-friendly address like www.google.com, instead of memorizing a number of digits. DNS databases are stored on computers called DNS servers. It is important to know that there is a very large world-wide network of hierarchically organized DNS servers, and no single DNS server contains the complete database. If a DNS server does not contain a requested domain name, the DNS server routes the request to another DNS server up the hierarchy. Eventually, the address will be found in the DNS database on a particular DNS server, and the corresponding IP address will be used to receive the request.

Your typical interaction with the Internet starts with a web browser when you:

Enter a URL like http://www.google.com into your web browser's address bar.
The browser creates an HTTP request, which is packaged up and sent to your device's network interface.
If your device already has a record of the IP address for the domain name in its DNS cache, it will use this cached address. If the IP address isn't cached, a DNS request will be made to the Domain Name System to obtain the IP address for the domain.
The packaged-up HTTP request then goes over the Internet where it is directed to the server with the matching IP address.
The remote server accepts the request and sends a response over the Internet back to your network interface which hands it to your browser.
Finally, the browser displays the response in the form of a web page.
The above set of steps is a simplification of what happens at a technical level. The main thing to understand though is that when your browser issues a request, it's simply sending some text to an IP address. Because the client (web browser) and the server (recipient of the request) have an agreement, or protocol, in the form of HTTP, the server can take apart the request, understand its components and send a response back to the web browser. The web browser will then process the response strings into content that you can understand. Navigating to websites like Facebook, Google and Twitter means you've been using HTTP all along. The details were hidden, but your browser was issuing the requests and processing the responses automatically. The different parts of the 

