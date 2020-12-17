# HTTPS

HTTPS encrypts the data before its transported through the network.

What could happen? Since session identifiers could be as a string in a request or response, a hacker could use "packet sniffing" techniques to retrieve the session id, use it to make a server request and effectively log in despite not having your username and password.

HTTPS sends messages through a cryptographic protocol called TLS, though before it was developed HTTPS used SSL (Secure Sockets Layer). These protocols use certificates to communicate with remote servers. They exchange security keys before data encryption happens

# Same-origin policy

An origin is the url's scheme, hostname, and port.

For http://mysite.com/doc1, http://mysite.com/doc2 has the same origin. But:
- https://mysite.com/doc1 has a different scheme (https vs http)ç´
- http://mysite.com:4000/doc2 has a different port
- http://anothersite.com/doc2 has a different host (anothersite.com vs mysite.com)

Same-origin policy permits resources from the same origin to have unrestricted interaction but limits some interactions between resources from different origins.

What's typically allowed is:
- Linking
- Redirects
- Form submissions
- Embedding resources (scripts, css stylesheets, images, fonts, iframes)

What's typically restricted is:
- Resources being accessed programmatically with APIs like `XMLHttpRequest` or `fetch`

The downside of same-origin policy is that it means that it restricts developers from doing certain actions, even if legitimate.

What was developed to deal with this issue is Cross-origin resource sharing (CORS), which allows interactions that would typically be restricted to take place when an origin is specified.

# Session hijacking

Session hacking is when a hacker gets hold of a session id stored in a cookie, as these are sent via the network to mimic stateful connections. For example, when a user's username and passwords match the session id is typically stored on their browser so they don't have to reauthenticate on the next request.

A few counter measures include:
- Using HTTPS to encrypt the data being sent across the network
- Resetting sessions, as this renders old sessions invalid and creates a new one
  - When settings are resetted, the user/s will have to reauthenticate in all sessions
  - For example, most websites force users to reauthenticate before entering a sensitive area like deleting an account or making a payment
- Setting an expiration time on sessions
  - Sessions that don't expire give attackers with the session id an unlimited time to pose as a threat
  - With an expiration time, they can only be a threat in that time window (as the id is stored on the server)

# Cross-Site Scripting (XSS)

Attackers could write malicious HTML and JavaScript code that could harm the site and users. For example, they could send code through a form (HTML `<textarea>`) that goes to the server. This might be executed if the server side code is not sanitized (note: **is this why we use URL encodings?**), causing the browser to interpret said code and execute it. This may cause malfunctions (e.g. an alert message to pop-up when it shouldn't) or the stealing of sensitive data.

Note that cross-site scripting would bypass same-origin policies because the attack would've been initiated from the origin

Some possible solutions include:
- Sanitize user input: eliminate troublesome inputs like HTML or JS input, or only allow safe formats like Markdown
- Escape user inputs when displaying it: escaping means to replace an HTML character with a combination of ASCII characters — which tells the client to display them as it is rather than interpret them
  - These combinations of ASCII characters are called HTML entities
  - E.g. `<p>Hello World!<\p>` would be replaced with `&lt;p&gt;Hello World!&lt;\p&gt;`
