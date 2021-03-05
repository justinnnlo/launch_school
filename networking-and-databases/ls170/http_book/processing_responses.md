The raw data returned by a server is a respone.

# Status code

A status code is a 3 digit number that the server sends back after receiving a request. The number signifies the status of the request.

`status text`, which is displayed alongside `status code`, described that code. For example, `status code` `200` has a `status text` `OK` which means that the request was successfully handled.

Other useful status codes are:

|Status code|Status Text|Meaning|
|-|-|-|
|200|OK|The request was handled successfully|
|302|Found|Requested resource has temporarily changed — usually redirects to another URL|
|404|Not found|Requested resource wasn't found|
|500|Internal Server Error|Server has encountered a generic error|

## 302 Found

When a resource is moved the most common strategy is to redirect a request to the new location/URL. This re-routing is called `redirect`.

When a browser sees a status code of `302` it will automatically follow the re-routed location found in the `Location` response header.

## 404 Not Found

This means that the requested resource can't be found in that URL/location.

The difference between the browser and HTTP tool is that the browser displays a nicely formatted text. In contrast, the tool shows the status code with the raw response.

## 500 Internal Server Error

This is a generic server error status code. The cause can be a host of things, hence why it's generic rather than specific (e.g. 404). However, it indicates that error comes from the server's side. As with 404 pages, 500 error code pages can vary widely.

# Response headers

Response headers have more information about the resource being sent back. Some common ones include:

|Header Name|Description|Example|
|-|-|-|
|Content-encoding|Encoding type used on the data|Content-Encoding: gzip|
|Server|Name of the server|Server: nginx|
|Location|Notify client of new resource location|Location: https://www.github.com/login|
|Content-Type|Data type contained by the response| Content-Type: text/html; charset=UFT-8|

Note that both request and response servers can even have subtly workflow effects (e.g. `Location` response header directing the browser to a new page). Both types of headers contain metadata about the request or response.

# Key components of an HTTP response
1. Status code
2. Header
3. Message body with the raw response data