# Context: HTTP and text

A major feature of HTTP is a text-based protocol. HTTP requests and responses travel through the network as plain text. This simplicity has a major downside: security.

Some security problems include:
- HTTP requests or responses can be easily read if intercepted
- Knowing if a request or response is trustworthy or has been tampered while it travelled through the network

This is important in the context of the transport layer. HTTP doesn't add any security — the transport layer does.

# Focus

TLS is a huge topic — so focus on understanding that:
1. TLS provides for secure message exchange over an unsecure channel (HTTP)
2. There are multiple aspects to security and each have their nuances

# TLS protocol

Transport Layer Security (TLS) protocol started as the Secure Sockets Layer (SSL) protocol — a Netscape proprietary protocol. SSL was standardized and renamed as TLS by the IETF in 1999 — which is why they are sometimes used interchangeably.

TLS provides 3 key security services:
1. Encryption
  - Encoding a message so that it can only be read by those authorized to decode it
2. Authentication
  - Verify the identify of a party in a message exchange
3. Integrity
  - Detect whether a message has been interfered or faked with

These 3 services don't have to necessarily be used simultaneously. For example, you can accept encrypted messages and receibe emails from senders who have not been authenticated previously.

## Encryption

TLS provides encryption via a TLS handshake.

### Cryptographic history

Ceasar's cipher was used by Julius Cesar to encrypt his messages. The problem with his cipher is that it relied on a fixed variation.

A more advanced variation is the Vigenere cipher from Blaise de Vigenere (XVI century). Like Cesar's cipher, Vigenere uses plain text and letter substitution. Unlike Cesar's cipher, instead of using a fixed pattern of substitution he uses a keyword alongside a *tabula recta* to cipher — and decipher — the text. Thus, only someone with the keyword — i.e., someone with authorization — can decipher the text.

### Symmetric Key Encryption

Vignere's mechanism of having sender and receiver share the same encryption key is used in many cryptographic systems today. This is known as a symmetric key encryption.

For example, my brother and I agree to exchange encrypted messages. We both keep a copy of the encryption key. I send an encrypted message to my brother, and he uses his key to decipher it and read it. This can also happen in reverse order.

This system only works if both sender and receiver have access to the encryption key. This raises a problem: how can they safely exchange encryption keys?

It's particularly important for internet encryption, as these can't be physically shared unlike between people. Therefore, what we need is a system to encrypt the encryption key so that even if it's intercepted it can't be used.

### Asymmetric (public) Key Encryption

This system uses a pair of keys: a public and private key. Unlike symmetrical key encryption, in this system the two keys are non-identical: the public key encrypts and the private key decrypts. Additionally, the public key would be publically accessible to anyone.

How would this work?

I create a pair of keys. I publish my public key and keep my private key private. My brother wants to send me a message, so he encrypts it using my public key and sends me the encrypted message. I use my private key to decrypt it and read its contents. Thus, even if it was intercepted it's undecyphreable.

Note that this works unidirectionally: my brother could send me an encrypted message, but I couldn't use the same encryption to send a message to my brother (he wouldn't have been able to decrypt it).

## TLS handshake

Secure HTTP messages need the request and response to be encrypted so that only the intended recipient can read it. This can be achieved with symmetric key encryption, but only if we encrypt the message when it's sent — otherwise, the encryption key could be intercepted and the security of the messages compromised.

This is what TLS does: it works with symmetric key encryption after sending them via asymmetric key encryption. Thus, the initial message is encrypted asymetrically using what's known as the TLS handshake.

TLS — through the TLS handshake — assumes that TCP is used as the transport layer protocol because the TLS handshake happens after the TCP handshake. It's process would look like:
1. TLS handshake begins with a `ClientHello` message sent by the client immediately after the TCP `ACK`
  - Message contains
    - Maximum version of the TLS protocol the client can support
    - List of cipher suits the client can use
2. The server receives `ClientHello` and responds with a message of its own — `ServerHello`
  - Message includes
    - Protocol version
    - Cipher Suite
    - Server certificate with its public key
    - `ServerHelloDone` marker: tells the client this step of the handshake is done
3. Client receives `ServerHelloDone` and starts the key exchange process
  - The exact process to generate the symmetric keys depends on which key exchange algorithm was selected as part of the Cipher Suite
4. Server sends a message with `ChangeCipherSpec` and `Finished` flags
  - Client and server can now communicate via the symmetric key encryption

Thus, as a process:
- Server and client agree on which TLS version to use (at server reply)
- Server and client agree on which Cipher Suite to use
- Client sends its public encryption key and server replies confirming it received it

Therefore, TLS handshake adds latency from 2 round trips:
1. `ClientHello` and `ServerHello`
2. Public key exchange which ends in the server's message with `Finished` flag

This is on top of the TCP handshake round trips, which also add latency.

Note: Datagrap Transport Layer Security is based on TLS and used for network connections that use UDP rather than TCP.

## Cipher Suites

A cipher is a cryptographic algorithm. It's the steps for performing the encryption, decryption and other tasks related to the algorithm. A cipher suite is a set of ciphers.

**TLS uses different ciphers for different parts of the process** of establishing and maintaining a secure connection. Parts include:
- Authentication
- Symmetric key encryption
- Checking message integrity

The combination of ciphers for performing each of these tasks form a cipher suite. The TLS handshake, as part of its process, agrees on which cipher suite to use. The client sends `ClientHello` with the Cipher suites it can use and the server replies with `ServerHello`, which sets the suite it chose to be used.

## TLS Authentication

A potential security problem is dealing with malicious messages. So far we've been able to encrypt messages, but what about message exchanges with 3rd parties that, e.g., want to steal our data by impersonating our bank?

As part of the server's response to `ClientHello`, the server sends to the client in `ServerHello` its certificate. Partly it's because the server's certificate holds its public key. But another is that it provides a way to identify the server — or any party sending a certificate.

The certificate includes details like who the owner is. A certificate on its own isn't robust — they are publicly available to anyone, so malicious 3rd parties could easily access them. Rather, the certificate and its public key are a part of an overall system of authentication that depends on the authentication algorithm selected as part of the cipher suite.

The process to verify that the certificate is sent by its owner would roughly look like:
- Server sends its certificate, which includes its public key
- The server creates a signature (some encrypted data) based on the server's private key
- The server transmits the signature with the original data from which the signature was created
- The client decrypts the signature using the server's public key and compares the decrypted data to the original data
- If the 2 versions matched than the encrypted data could only have been sent from a party that held the private key — and thus the owner of the certificate

But what about fake certificates?

Certificates are more likely to be accepted as genuine if they come from a trustworthy source. These are called Certificate Authorities (CAs).

When a CA issues a certificate, it:
1. Verifies that the party requesting the certificate is who they say they are
  - Depends on the type of certificate being requested
2. Digitally signs the certificate being issues
  - Usually encrypts some data with the CAs private key and using this encrypted data as a signature

There are different levels of CA:
- Root CA
  - Small group of organizations approved by browser and operating system vendors
    - Approved through reputation derived from prominence and longevity
  - Issues "root certificates", which are self-signed (ie, signed by the root CA) — the end point in the trust chain
- Intermediary CA: a company or body that issues certificates on behalf of the CA that authorized it
  - It issues site certificates on behalf of root CAs

Thus, when a site certificate is issued by an intermediary CA there are multiple levels of certificates:
- Site certificate
  - Issued by the CA
  - Holds: name, public key, issuer's name, and issuer's signature
    - The issuer's signature is verified by the intermediate CA's public key
- Intermediate CA's certificate
  - Issued by the root CA
  - Holds: name, public key, issuer's name, and issuer's signature
    - The issuer's signature is verified by the root CA's public key
- Root CA's certificate
  - Self-issued
  - Holds: name, public key, and signature
    - The signature is verified by its public key

This is what is prefered: for there to be multiple levels of certificates to keep the Root CAs private keys behind as many security layers as possible. Thus, they don't issue end-user certificates and leave that to intermediary CAs. If intermediary CA private keys become compromised, root CA can revoke its certificate — thus invalidating all dependent certifictes down the chain — and issue a new one.

Yet this isn't infallible: in 2015 Symantec issued fake Google Certificates.

## TLS integrity

On top of the functionality above, TLS can check the integrity of data transported on the protocol via TLS data encapsulation.

### TLS Encapsulation

OSI defined TLS as a Session layer model — before TCP and after the Application and Presentation layers.

As other PDU, TLS places the data it needs to encapsulate within its payload and stores the metadata in its header (and trailer, if relevant) fields.

The main header field of the TLS PDU is the MAC: Message Authentication Code. This is different from a MAC address (Media Access Control address) burned into computers and used by routers to manage IP addresses.

### Message Authentication Code (MAC)

This is similar to the checksum fields seen in other PDUs, though there are nuances in how it's implemented and in its intention.

Checksum in, e.g., a TCP segment is made for error detection in case some was corrupted during transport. The MAC field in a TLS *record* **checks that the message hasn't been altered or tampered with in transit**.

This is implemented through a hashing algorithm:
1. The sender creates a digest of the data payload
  - Digest: a small amount of data derived from the actual message data
  - Digest created with a specific hashing algorithm combined with a pre-agreed hash value
    - Hashing algorithm and hash value will have been agreed as part of TLS handshake when the Cipher Suite was negotiated
2. Sender then:
  - Encrypts data payload using the symmetric key
  - Encapsulate it into a TLS record (the PDU)
  - Passes this record to the transport layer
3. Upon reception
  - The receiver will decrypt the data payload with the symmetric key
  - Received will create a payload digest with the same algorithm and hash value
    - If the 2 digests match, it verifies the message's integrity
