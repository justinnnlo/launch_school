https://launchschool.com/books/http/read/what_is_a_url

# URLs
- Be able to identify the components of a URL, including query strings

`https://amazon.com/Double-Stainless-Commercial-Refrigerator/B60HON32?ie=UTF8&qid=142952676&sr=93&keywords=commercial+fridge`

Host: amazon.com
Query parameter NAMES: ie, qid, sr, keywords
Query parameter VALUES: UTF8, 142952676, 93, commercial+fridge

Scheme: https
Path: /Double-Stainless-Commercial-Refrigerator/B60HON32
Port: 443 is inferred but not present



- Be able to construct a valid URL
✅

- Have an understanding of what URL encoding is and when it might be used

2 ways to encode a space: %20 or +
character between query params: &
to start a query param list: ?
to indicate KV: =

URL encoding is used to convert unsafe characters in a URL into a format that can be transmitted. THe ASCII character-set is what's available for a URL, so some characters need to be converted into a valid ASCII format. "URL encoding replaces unsafe ASCII characters with a "%" followed by two hexadecimal digits."

ASCII Encoding Reference: https://www.w3schools.com/tags/ref_urlencode.ASP


# URL versus URI

> URLs are "the most frequently used part of the general concept of a Uniform Resource Identifier or URI".
> According to RFC3986, a URI is "sequence of characters that identifies an abstract or physical resource", and a URL refers to:

> the subset of URIs that, in addition to identifying a resource, provide a means of locating the resource by describing its primary access mechanism (e.g., its network "location").

> We can take from this that a URL is a subset of URI that includes the network location of the resource. 

# Schemes versus protocols

> When looking at URL Components, we described the component that prepends the colon and two forward slashes at the start of a URL as the scheme.
The scheme identifies which protocol should be used to access the resource. Protocol in this sense refers to a family of protocols. 

---

URL Encoding
URLs are designed to accept only certain characters in the standard 128-character ASCII character set. Reserved or unsafe ASCII characters which are not being used for their intended purpose, as well as characters not in this set, have to be encoded. URL encoding serves the purpose of replacing these non-conforming characters with a % symbol followed by two hexadecimal digits that represent the ASCII code of the character.

Below are some popular encoded characters and example URLs:

Character	ASCII code	URL
Space	20	http://www.thedesignshop.com/shops/tommy%20hilfiger.html
!	21	http://www.thedesignshop.com/moredesigns%21.html
+	2B	http://www.thedesignshop.com/shops/spencer%2B.html
#	23	http://www.thedesignshop.com/%23somequotes%23.html
Characters must be encoded if:

They have no corresponding character within the standard ASCII character set.
The use of the character is unsafe because it may be misinterpreted, or even possibly modified by some systems. For example % is unsafe because it can be used for encoding other characters. Other unsafe characters include spaces, quotation marks, the # character, < and >, { and }, [ and ], and ~, among others.
The character is reserved for special use within the URL scheme. Some characters are reserved for a special meaning; their presence in a URL serve a specific purpose. Characters such as /, ?, :, @, and & are all reserved and must be encoded. For example & is reserved for use as a query string delimiter. : is also reserved to delimit host/port components and user/password.
So what characters can be used safely within a URL? Only alphanumeric and special characters $-_.+!'()", and reserved characters when used for their reserved purposes can be used unencoded within a URL. As long as a character is not being used for its reserved purpose, it has to be encoded.