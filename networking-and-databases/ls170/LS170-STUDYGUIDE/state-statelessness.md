Since the HTTP protocol is stateless, requests are not aware of each other, i.e. each request we make is treated as a brand new request. 

That might not sound right when you think about features like logging in and being able to navigate between pages of a site without logging in for each page click or refresh. 

The way that we emulate state on the web is with sessions, cookies, and asynchronous JavaScript calls (AJAX).

We create sessions with unique tokens that we call session identifiers. The session identifier token is passed between the client and the server to create a sense of a persistent connection. It is important to remember that the requests still remain stateless though. 

Sessions take up a lot of compute power, because the request has to inspect to see if there is a session identifier. If there is, the server needs to retrieve the session data based on the session id and recreate the application state from that session data so it can send it to the client as a response. 

The session information is stored in the browser in the shape of **HTTP cookies**. HTTP cookies ae small files. When you access a site/ make a request to a site for the first time, the server sends session information and stores it in you browser cookie on your local computer. While the actual session data is stored on a server, the cookie is used to compare the cookie to the server-side session data to identify the current session. Headers can be seen related to the cookie process: ***set-cookie*** adds cookie data to the response header, while ***cookie*** becomes part of the request headers and contains the cookie data previously sent by the set-cookie response header. 

This persists until you end the session or it expires. 

Another option for statefulness is AJAX, which stands for "Asynchronous JavaScript and XML". When AJAX is used, the page is not refreshed each time a new request is sent because the request is performed asynchronously. Basically, each time you press a key, an AJAX request is triggered, and the responses from the AJAX requests are processed by a callback. Overall, AJAX requests are the same as any normal request but instead of a browser refresh when processing the response, it's generally handled instead by some client-side JavaScript code. 



-- An example is if you type in some search keywords and as you type each letter you see some results reoganizing on the screen


https://launchschool.com/books/http/read/statefulness


==--

https://launchschool.com/books/http/read/statefulness

https://launchschool.com/books/http/read/background

> Statelessness
A protocol is said to be stateless when it's designed in such a way that each request/response pair is completely independent of the previous one. It is important to be aware of HTTP as a stateless protocol and the impact it has on server resources and ease of use. In the context of HTTP, it means that the server does not need to hang on to information, or state, between requests. As a result, when a request breaks en route to the server, no part of the system has to do any cleanup. Both these reasons make HTTP a resilient protocol, as well as a difficult protocol for building stateful applications. Since HTTP, the protocol of the internet, is inherently stateless that means web developers have to work hard to simulate a stateful experience in web applications.

When you go to Facebook, for example, and log in, you expect to see the internal Facebook page. That was one complete request/response cycle. You then click on the picture -- another request/response cycle -- but you do not expect to be logged out after that action. If HTTP is stateless, how did the application maintain state and remember that you already input your username and password? In fact, if HTTP is stateless, how does Facebook even know this request came from you, and how does it differentiate data from you vs. any other user? There are tricks web developers and frameworks employ to make it seem like the application is stateful, but those tricks are beyond the scope of this book. The key concept to remember is that even though you may feel the application is stateful, underneath the hood, the web is built on HTTP, a stateless protocol. It's what makes the web so resilient, distributed, and hard to control. It's also what makes it so difficult to secure and build on top of.