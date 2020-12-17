TLS (Transport Layer Security) is a protocol used with HTTP to provide secure message transfer. Overall, it provides for secure message exchanges over an unsecure channel.

Three important services are provided by TLS for security:
- Encryption
- Authentication
- Integrity

These services don't all need to be used simultaneously but they usually are.

## Encryption

TLS sets up an encrypted connection using the TLS Handshake, which enables assymetric key encryption between client and server, followed by symmetric key encryption. 

To complete the handshake, the client sends a message `ClientHello` after the TCP `ACK` from the TCP handshake. The message contains a few things: the maximum version of the TLS protocol they support and a list of Cipher suites that can be used for encryption.

Then, the server responds with a `ServerHello` message to set the protocol version and Cipher Suite, and provides a certificate that contains its public key. Since that step of the handshake is done, it sends a `ServerHelloDone` marker as well.

After the client receives that marker, it can initiate the key exchange process. Then the server sends a message with `ChangeCiperSpec` and `Finished` flags.

Now both client and server can begin secure communications using the symmetric key.


The key thing to remember is the TLS Handshake is used to: 

- Agree which version of TLS to be used in establishing a secure connection.
- Agree on the various algorithms that will be included in the cipher suite.
- Enable the exchange of symmetric keys that will be used for message encryption.


https://launchschool.com/lessons/74f1325b/assignments/95e698ab
## Authentication

An additional functions of the certificate that is provided is to server as identification. The certificate has information on who the owner is, which can be used in conjunction with the public key for authentication. In general, for authentication, the server will send its certificate, which includes the public key. An encrypted 'signature' is created, which includes the server's private key. That signature is transmitted and the client receives it and decrypts the signature using the server's public key. SO long as the decrypted version matches the original version, then the encrypted version could only have been created by a party that holds the private key and is therefore authenticated. 

These certificates are created by Certificate Authorities, usually by an Intermediate CA, like Let's Encrypt, which is verified by a Root CA. The root CA can revoke certificates for intermediate and invalidate all of the certificates down the chain from it as needed. 


## Integrity

A third function of TLS is to check the integrity of data transported via the protocol. 

The Message Authentication Code (MAC) is a means of checking that a message has not been altered/tampered with during transit. A hashing algorithm that creates a digest of the data payload is used. (The hashing algorithm is decided on during the TLS Handshake). 

Then the sender encrupts the data payload using the symmetric key, encapuslates it in a TLS record, and sends it on to the transport layer. The receiver then decrypts the data payload using the symmetric key. The receiver also creates a digest of the payload using the same hashing algorithm and value. If they match, this confirms the integrity of the message.