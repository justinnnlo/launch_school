# HTTP and the Request/Response Cycle
- Be able to explain what HTTP requests and responses are, and identify the components of each
- Be able to describe the HTTP request/response cycle 📝

----
MY WRITTEN DESCRIPTION:

Hypertext Transfer Protocol (HTTP) is a protocol that defines how resources on the web are transferred between applications, i.e. how machines communicate with each other. The general model is simple: a **client** (usually your browser) makes a **request** to a server and waits for a **response**. We call that **reqest response protocol**. 

The requests follow a specific format and can have many types. The most common request types we send are `GET` and `POST` requests. `GET` and `POST` are called the **HTTP Request Methods**. `GET` is used for retrieving information from a target address, whereas `POST` is used for submitting information. In addition to providing the HTTP request with a method, we also need to provide a path, host, and HTTP version. HTTP is a suite of different versions of the protocol. We can add some optional parameters, like search queries, when we make a request. 

A common use case for the `POST` method would be submitting a form and/or sending a username or password to the server for authentication, and it solves problems that a `GET` request has–anonymity and query string size. The difference is that in a `POST` request, the data we send is part of the HTTP **body** instead of a query parameter. 

After we submit a POST request, the browser sees a response header and issues a new request to a URL specified in a `Location` response header. 

HTTP headers are like metadata about your request. They tell things like what type of connection to have, how long the content is, what type of content it is (so the browser knows how to display it), and more. There are both Request and Response headers. 

To recap, after sending a request to a server, we'll receive a response. Sometimes the response is not what we want: errors can happen when we make a request. We might type in the wrong path such that the resource can't be found, the resource might've been moved, or something might be wrong with the server with the resource altogether.

These types of issues are communicated in the Response Header for the Status Code and Status Text. The Status 200 is what we want to see, that means that everything is okay. On the other hand, if we type in a path that doesn't exist we'll usually get a 404 error, which means the requested resource can't be found. If we get a 302 error that means that the requested resource has been changed, perhaps from a redirect to another URL. If a company changes their URL or even just changes a path for a resource, they'll set up redirects so users can still access the content if they have an old link cached (and so they still rank well with the Google search algorithm). The final error worth mentioning is a 500 error, which is an Internal Server Error. This can mean any type of error and requires debugging on the server side. 

There are some other Response Headers worth mentioning:
- Location - Notifies clients of new resource location
- Content-Type: Tells the browser what type of data the response contains

Overall, the most important details of the response are the status code, headers, and the message body that has the raw data. 

Another thing to note is that a resource you use on the web is usually a BUNCH of resources all in one. When you make a request to the site, it'll send the first request, which will automatically make requests for any needed resources for displaying the content. If you look in the browser console network tab, you can see a summary of how many resources are sent when loading a new resource. 



---
Response
Status shows the response status for each request. 




When we make a request, it's usually initally to a DNS server that can look up the IP address of the URL we typed in. Once we get the IP address of the name server of the host/domain name, then we can send our request to that destination (unless of course the IP address is already ***cached*** i.e. saved in your browser cache, in which case it has that identity map already). The remote server accepts our request and sends a response over the internet to our network interface, which ultimately hands it to the browser. The browser then displays the response. 




# Practice
1.  What are the required components of an HTTP request? What are the additional optional components?

- The HTTP method and the path are required. As of HTTP 1.0, the HTTP version is also part of the request-line. The `HOST` header is a required component since HTTP 1.1

- The HTTP method and the path form what is known as the start-line or request-line.

- Technically speaking the 'path' portion of the request-line is known as the 'request-URI', and incorporates the actual path to the resource and the optional parameters if present. In practice, most people simply refer to this part of the request-line as the 'path'.

2. What are the required components of an HTTP response? What are the additional optional components?

- Status code is required. Headers and body are optional.

3. What determines whether a request should use GET or POST as its HTTP method?

- `GET` requests should only retrieve content from the server. They can generally be thought of as "read only" operations, however, there are some subtle exceptions to this rule. For example, consider a webpage that tracks how many times it is viewed. `GET` is still appropriate since the main content of the page doesn't change.

- `POST` requests involve changing values that are stored on the server. Most HTML forms that submit their values to the server will use `POST`. Search forms are a noticeable exception to this rule: they often use GET since they are not changing any data on the server, only viewing it.