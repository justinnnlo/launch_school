When we send requests and responses, those are being sent as strings. Due to this, there are a number of security issues.

- ***packet sniffing*** - A malicious hacker on the same network reads the messages that are being sent back and forth

As a sub-issue, the malicious hacker could obtain your session id then send a request to the server posing as you client, which would log them in without even knowing your credentials.

Secure HTTP, AKA HTTPS, which is HTTP with TLS, employes techniques like encryption to thwart packet sniffers and other malicious activity.

The encryption aspect is handled by the crypographic protocol TLS (Transport Layer Security).

{ADD IN CONTENT FROM TLS STUDY GUIDE}

Another useful feature of HTTPS is the Same-origin policy. This policy permits unrestricted interaction between resources that originate from the same origin, but restricts resources from other origins. Three aspects are related to the origin: the scheme, port, and host. What it actually blocks are requests for resources that are accessed programmatically using APIs like `XMLHttpRequest` and `fetch`. Of course, there are times when we need to use resources from other origins, so cross-origin resource sharing (CORS) was made to handle those types of requests by adding in in HTTP headers so the servers can server resources cross-origin to allowed origins. 

Overall, the same-origin policy is a guardian against session hijacking attacks.

--

Another security risk is ***session hijacking***, whereby the malicious attacked gets a hold of the session id and can access the web application with that session data. 

Countermeasures:
- Resetting the session. A new session will be created and the old one will expire.
- Setting an expiration on sessions. All users will have to log back in, so the attacker won't have an infinite time to use your session.
- HTTPS - HTTPS minimizes opportunities for an attacker to access session ids.


Cross-Site Scripting AKA XSS, is an attack that happens when the attacker injects custom code into your site. For example, if you have a form where the attacker can submit HTML, they can very easily add HTML and JavaScript to your site unless you sanitize any data that is submitted. The browser would othewise interpret the HTML and JavaScript and execute it. In addition to sanitizing user input, the input can simply be escaped, so it's not understood by the the browser as executable code. 

