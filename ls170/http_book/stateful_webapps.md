HTTP is a stateless protocol — each request/response cycle is independent and **the server does not hold data between cycles**.

Statelessness makes HTTP ¿distributed? and what makes building webapps with states difficult. For example, if we log in to FB that's a reuqest/response cycle. But if HTTP is stateless — if the server doesn't hang on to data between cycles — how will FB know during the next cycle to keep the user logged in?

# What is a stateful app?

# Sessions

The client (ie browser) can help HTTP mimic a stateful connection.

The server can send a unique token to the client. If appended by the client when making a request, the server identifies the client. This unique token being passed is called a **session identifier**.

So even though each cycle is stateless — the server doesn't hold information between cycles — it mimics a stateful connection through the information supplied by the session identifier.

The implications of this faux statefulness include:
- Every request must be inspected for the session identifier
  - If it has a session identifier, the server must check if it's valid
  - Therefore, the server needs rules to manage i) session/identifier expiration and ii) how to store the data
    - If it's valid, the server needs to retrieve the session data based on the session id, recreate it and send it back to the client

Key downside: performance.
- Every request gets its own response, even if it's almost identical
  - Thus, if you click on a like on FB it'd have to regenerate the whole page because it's a new cycle — and a new session identifier that the browser is given.
- The server needs to check each request for a session identifier (though this is probably minimal)

# Cookies

An cookie is a small text file (that's sometimes encrypted) that's sent by the server to help the browser navigate a website. The data stored in the text file is session information. Cookies are stored in a browser's folder or subfolder, and accesses the cookie when you visit the website that created the cookie file.

When you access a website for the first time the server sends session information through the browser cookie (**note: doesn't it send it via the HTTP response?**) that is then stored in your computer. Each subsequent request will have the latest cookie in its header — ie, it'll be sent to the server each time you make a request to uniquely identify your client/browser.

Though the browser cookie is stored in the browser (and persists even if you close the browser and shut doen the computer), the actual session info is stored in the server. The exact place on the server could vary: e.g. stored in memory, persistent storage like a databae or key/value, etc. What's critical is that the session id stored in the client is used as a "key" to the session data stored on the server.

# AJAX

Asynchronous Javascript and XML. It allows browsers to issue requests and process responses without *fully* reloading the page.

An AJAX request is like a normal HTTP request. They're sent with the normal components and the server handles it as any other request. The difference is that the response is processed by a callback function — usually a client-side JavaScript code — instead of the browser refreshing and processing the response.

For example, in Google when you are typing a search the changing predictive results occur because of AJAX — a new AJAX request is triggered when a key is pressed.