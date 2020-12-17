# The Transport Layer Security (TLS) Protocol

The Transport Layer Security (TLS) protocol started life as a protocol called SSL (Secure Sockets Layer). This was a proprietary protocol developed by Netscape. Although it was standardized and renamed as TLS in 1999 by the IETF, the terms are often still used interchangeably. You'll commonly still hear people talk about SSL Certificates rather than referring to them as TLS Certificates or Public Key Certificates. When you hear SSL being mentioned, just bear in mind that the person saying it is probably referring to TLS, unless they are speaking historically.

There have been several version of TLS since 1999, the most recent one being TLS 1.3.

There are three important security services that are provided by TLS: Encryption, Authentication, and Integrity. Each of these services are important in their own right, but when combined they provide for very secure message exchange over what is essentially an unsecure channel. Let's look a bit more closely at the nature of these services.

Encryption: a process of encoding a message so that it can only be read by those with an authorized means of decoding the message

Authentication: a process to verify the identity of a particular party in the message exchange

Integrity: a process to detect whether a message has been interfered with or faked

It isn't mandatory for an application which uses TLS that all three of these services are used simultaneously. For example, you could design your application to accept encrypted messages from a sender without authenticating who they are. In practice however, all three services are generally used together to provide the most secure connection possible.

# TLS Encryption

Encryption is a major component of the security provided by TLS. The way in which TLS sets up an encrypted connection is via a process known as the TLS Handshake. Before we look in more detail at how this process works, let's first try to understand the problem that it aims to solve.

A Brief History of Cryptography

Cryptography, that is to say the use of techniques for securing communication, has been in use for thousands of years. An ancient example is the Caesar cipher, which was a simple substitution cipher used by Julius Caesar to encrypt sensitive stategic messages he sent to his commanders during the various military campaigns undertaken by the Roman Empire.

Simple graphic illustrating the mechanics of a substitution cipher

Simple substitution ciphers such as this are a fairly weak form of encryption however, and are relatively easy to 'crack'.

In the 16th Century, a French cryptographer called Blaise de Vigenere popularised a new cryptographic system which came to be known as the Vigenere cipher. In this system, as with the Caesar cipher, letter substitution is still used to encrypt the plain text. The major difference in Vigenere is that rather than a fixed pattern of substitution, a keyword is used along with a tabula recta in order to produce the cipher text. The theory behind this approach is that only those also in possession of the keyword can decrypt the ciphertext.

Simple graphic illustrating the mechanics of the Vigenere cipher

Symmetric Key Encryption

Cryptography has evolved over time with regards to the complexity of encryption algorithms and the sophistication of encryption keys. Despite these advances, the underlying concept seen in the Vigenere cipher, whereby sender and receiver share a common encryption key, is still used in modern cryptographic systems. A shared key system such as this is known as symmetric key encryption.

Alice and Bob want to exchange messages securely. They both agree on a secret key and keep a copy of it. Alice can then encrypt a message using the key and send it to Bob. Bob can decrypt the message using the same key. The same process can be carried out in the other direction for messages that Bob sends to Alice.

Simple Alice and Bob graphic illustrating the mechanics of symmetric key encryption

In order to work securely, this system relies on the sender and receiver both having access to the key and no one else being able to access it. This raises the question: how do sender and receiver exchange encryption keys in the first place?

The most secure way to exchange keys would be in person. If we want to use symmetric key encryption over the internet however, this isn't a feasible option. We also can't just send the key in a readable format to the other party in our message exchange; if the key was intercepted by a third-party, they could then use it to decrypt any subsequent messages between the sender and receiver. What we need is a mechanism whereby we can encrypt the encryption key itself, so that even if it is intercepted it can't be used.

Asymmetric Key Encryption

Asymmetric key encryption, also known as public key encryption, uses a pair of keys: a public key, and a private key. Unlike the symmetric system where the same key is used to encrypt and decrypt messages, in the asymmetric system the keys in the pair are non-identical: the public key is used to encrypt and the private key to decrypt.

The exact mechanism by which these keys are generated is beyond the scope of this course. The important thing to understand is that messages encrypted with the public key can only be decrypted with the private key. The public key is made openly available but the private key is kept in the sole possession of the message receiver.

Alice wants to receive encrypted messages. She generates a public key and a private key. She makes the public key available but keeps the private key to herself. Bob uses Alice's public key to encrypt a message and send it to Alice. Alice decrypts Bob's message using her private key.

Simple Alice and Bob graphic illustrating the mechanics of asymmetric key encryption

An important thing to note here is that this encryption is primarily intended to work in one direction. Bob can send Alice messages encrypted with the public key which she can then decrypt with the private one. The same key pair would not be used in the other direction for secure communication, since anyone with access to the public key can decrypt the message.

The TLS Handshake

To securely send messages via HTTP we want both the request and the response to be encrypted in a such a way that they can only be decrypted by the intended recipient. The most efficient way to do this is via symmetric key cryptography. If we want to use symmetric keys however, we also need a way to securely exchange the symmetric key.

The clever thing about TLS is the way that it uses a combination of symmetric and asymmetric cryptography. The bulk of the message exchange is conducted via symmetric key encryption, but the initial symmetric key exchange is conducted using asymmetric key encryption. The process by which the initial secure connection is set up is conducted during what is known as the TLS handshake.

TLS assumes TCP is being used at the Transport layer, and the TLS Handshake takes place after the TCP Handshake. A step-by-step description of the TLS Handshake process might look something like this:

The TLS Handshake begins with a ClientHello message which is sent immediately after the TCP ACK. Among other things, this message contains the maximum version of the TLS protocol that the client can support, and a list of Cipher Suites that the client is able to use (we'll discuss Cipher Suites a little later on).

On receiving the ClientHello message, the server responds with a message of its own. This message includes a ServerHello, which sets the protocol version and Cipher Suite, as well as other related information. As part of this message the server also sends its certificate (which contains its public key), and a ServerHelloDone marker which indicates to the client that it has finished with this step of the handshake.

Once the client has received the ServerHelloDone marker, it will initiate the key exchange process. It's this key exchange process that ultimately enables both the client and server to securely obtain a copy of the symmetric encryption key that will be used for the bulk of the secure message transfer between the two parties. The exact process for generating the symmetric keys will vary depending on which key exchange algorithm was selected as part of the Cipher Suite (e.g. RSA, Diffie-Hellman, etc). You don't need to worry about the distinctions between these key exchange mechanisms, but as an example RSA works in the following way:

The client generates what's known as a 'pre-master secret', encrypts it using the server's public key, and sends it to the server.
The server will receive the encrypted 'pre-master secret' and decrypt it using its private key.
Both client and server will use the 'pre-master' secret, along with some other pre-agreed parameters, to generate the same symmetric key.
As part of the communication which includes the ClientKeyExchange message (e.g. the pre-master secret), the client also sends a ChangeCipherSpec flag, which tells the server that encrypted communications should now start using the symmetric keys. Additionally this communication includes a Finished flag to indicate that the client is now done with the TLS Handshake.
The server also sends a message with ChangeCipherSpec and Finished flags. The client and server can now begin secure communication using the symmetric key.

Graphic illustrating the steps of TLS Handshake

As you can see, the TLS Handshake is a fairly complicated process. We certainly don't expect you to memorize every detail of the various steps involved. Instead, try to form a high-level mental model for how it works. Note also that the exact process will vary according to which version of TLS is used. The key points to remember about the TLS Handshake process is that it is used to:

Agree which version of TLS to be used in establishing a secure connection.
Agree on the various algorithms that will be included in the cipher suite.
Enable the exchange of symmetric keys that will be used for message encryption.
Something you should be aware of is that one of the implications of this complexity is its impact on performance. The TLS handshake can add up to two round-trip of latency (depending on the TLS version) to the establishment of a connection between client and server prior to the point where any application data can be sent. This is on top of the initial round trip resulting from the TCP Handshake.

Note: there is a protocol called Datagram Transport Layer Security (DTLS), which is based on TLS. This protocol is specifically for use with network connections which use UDP rather than TCP at the Transport layer.
Cipher Suites

During the description of the TLS Handshake, we mentioned Cipher Suites a few times. So what exactly is a Cipher Suite?

A cipher is a cryptographic algorithm; in other words they are sets of steps for performing encryption, decryption, and other related tasks. A cipher suite is a suite, or set, of ciphers.

TLS uses different ciphers for different aspects of establishing and maintaining a secure connection. There are many algorithms which can be used for the performing the key exchange process, as well as for carrying out authentication, symmetric key encryption, and checking message integrity.

The algorithms for performing each of these tasks, when combined, form the cipher suite. The suite to be used is agreed as part of the TLS Handshake. As part of the ClientHello message, the client sends a list of algorithms it supports for each required task, and the server chooses from these according to which algorithms it also supports.

# TLS Authentication

Being able to transfer data in an encrypted form is all well and good, but what if the source of that encrypted data is malicious? For example, you could be communicating with what you think is your bank, but is in fact a third-party impersonating your bank. Having an encrypted communication channel in this situation doesn't keep you secure from that malicious third-party. In fact it could put you more at risk; since the channel is encrypted you might be more willing to share sensitive data such as credit card details. What we need is a means of identifying the other party in our message exchange.

During the TLS Handshake, as part of its response to the ClientHello message, the server provides its certificate. As outlined in the Encryption section, part of the function of this certificate is so that the client can use the Public Key contained within it during the key exchange process. Another function of this certificate is to provide a means of identification for the party providing it.

The certificate will contain various pieces of information, including who the owner is. The certificate on its own isn't much proof of anything, however. Since such certificates are publicly available to anyone, a malicious third-party could easily access one and present it as its own. The certificate, and the Public Key it contains, are only one part of an overall system of authentication.

The exact way that the Public Key is used during this process varies depending on the Authentication algorithm selected as part of the Cipher Suite. Generally however, this process will be something along the following lines:

The server sends its certificate, which includes its public key.
The server creates a 'signature' in the form of some data encrypted with the server's private key.
The signature is transmitted in a message along with the original data from which the signature was created.
On receipt of the message, the client decrypts the signature using the server's public key and compares the decrypted data to the original version.
If the two versions match then the encrypted version could only have been created by a party in possession of the private key.
Following a process such as this we can identify that the server which provided the certificate during the initial part of the TLS Handshake as being in possession of the private key, and therefore the actual owner of the certificate.

There's still an issue here though. What's to stop a malicious third-party creating their own key pair and certificate identifying them as, say, a well-known bank? Just as it's possible to create a fake ID card in the real world, it's possible to create a fake digital certificate. How are we to know if a certificate is genuine or not? This is where Certificate Authorities come in.

Certificate Authorities and the Chain of Trust

If you are presented with a piece of identification, you are much more likely to accept it as genuine if it has been issued by a trustworthy source. When it comes to digital certificates, the trustworthy sources are called Certificate Authorities (CAs).

When a CA issues a certificate, it does a couple of important things:

Verifies that the party requesting the certificate is who they say they are. The way that this is done is up to the CA and will depend to an extent on the type of certificate being issued. In the case of a domain validated server certificate, for example, it can involve proving that you own the domain by uploading a specific file to a server that is accessible by the domain for which the certificate is being issued.

Digitally signs the certificate being issued. This is often done by encrypting some data with the CA's own private key and using this encrypted data as a 'signature'. The unencrypted version of the data is also added to the certificate. In order to verify that the certificate was issued by the CA, the signature can be decrypted using the CA's public key and checked for a match against the unencrypted version.

So who exactly are these Certificate Authorities, and why should we trust them? There are different 'levels' of CA. An 'Intermediate CA' can be any company or body authorised by a 'Root CA' to issue certificates on its behalf. A widely-used Intermediate CA is Let's Encrypt, who provide free, automated certificates.

Google have their own Intermediate CA called Google Internet Authority, who issue certificates for all of Google's own domains. If you view the certificate for https://www.google.com, you'll be able to see this Intermediate CA listed in the Certificate Hierarchy. The way you view the Certificate Hierarchy will vary depending on the browser you use. For Chrome, click on the padlock icon in the address bar and in the resulting pop-up menu click on 'Certificate'.

Screenshot of clicking on padlock icon in Google Chrome, and the resulting popup menu

In the Certificate Viewer, click on the 'Details' tab. At the top you should be able to see the Certificate Hierarchy.

Screenshot of Certificate Viewer details tab, showing Certificate Hierarchy for google.com

If you select www.google.com in the Certificate Hierarchy List and then click on Issuer in the Certificate Fields window, the Field Value should show something like CN = Google Internet Authority G3 (CN here refers to Common Name), which indicates that Google Internet Authority is the issuer of the certificate for www.google.com.

If you select Google Internet Authority in the Certificate Hierarchy List and follow the same process, you should see that the issuer for this certificate is GlobalSign. This is the 'chain of trust' from google.com to Google Internet Authority to GlobalSign.

If you do the same thing again to check the issuer of GlobalSign's certificate however, you'll see that this is also GlobalSign. GlobalSign is a root CA and its certificate is what's known as a Root Certificate. Root Certificates are 'self-signed', and are essentially the end-point of the chain of trust.

Client software, such as browsers, store a list of these authorities along with their Root Certificates (which includes their public key). When receiving a certificate for checking, the browser can go up the chain to the Root Certificate stored in its list.

Diagram showing chain of trust structure

The purpose of this chain-like structure is the level of security it provides. The private keys of the Root CAs are kept behind many layers of security in order to be kept as inaccessible as possible. As such they don't issue end-user certificates, but leave that up to the Intermediate CAs. Additionally, if the private key of an Intermediate CA somehow became compromised, the root CA can revoke the certificate for Intermediate, therefore invalidating all of the certificates down the chain from it, and simply issue a new one.

It is necessary that such a 'chain of trust' would need to have an end-point, but if no-one is authenticating the Root CAs other than themselves, how do we know we can trust them? The answer to this is simply their reputation gained through prominence and longevity. Root CAs are essentially a small group of organisations approved by browser and operating system vendors.

Ultimately this system still relies on trust, and as such isn't infallible. In 2015 Symantec issued some fake Google Certificates. Although the issue was quickly spotted and fixed, it shows that this security infrastructure isn't necessarily 100% reliable.

# TLS Integrity

The Encryption and Authentication capabilities of TLS already provide us with a pretty secure system. To add a further layer of security, TLS provides the functionality to check the integrity of data transported via the protocol.

To get a clearer picture of how this functionality works, we need to take a step back and look at how the TLS protocol encapsulates data.

TLS Encapsulation

The OSI model defines TLS as a Session layer protocol, and so existing in between Application layer (where HTTP resides) and the Transport layer (where TCP resides). Although, as previously stated, we're not too interested in the specifics of how the OSI Model defines these intervening layers, when thinking about TLS it can be useful to think of it as operating between HTTP and TCP.

Just like other protocols we've looked at in this course, TLS sends messages in a certain format. This format can vary depending on the particular function that TLS is performing, but when it is transporting application data TLS encapsulates that data in the same way that we've seen with other Protocol Data Units. In other words, the data to be transported forms a payload, and meta data is attached in the form of header and trailer fields.

Diagram showing structure of TLS record

The main field that interests us in terms of providing message integrity is the MAC (Message Authentication Code) field. Note that, though they use the same acronym, the Message Authentication Code is completely unrelated to the MAC Address (media access control address) discussed in an earlier lesson.

Message Authentication Code (MAC)

The MAC field is similar in concept to the checksum fields we've already seen in other PDUs, although there is a difference in implementation as well as overall intention. The checksum field in, say, a TCP Segment is intended for error detection (i.e. to test if some data was corrupted during transport). The intention of the MAC field in a TLS record is to add a layer of security by providing a means of checking that the message hasn't been altered or tampered with in transit.

The way this is implemented is through the use of a hashing algorithm. It works something like this:

The sender will create what's called a digest of the data payload. This is effectively a small amount of data derived from the actual data that will be sent in the message. The digest is created using a specific hashing algorithm combined with a pre-agreed hash value. This hashing algorithm to be used and hash value will have been agreed as part of the TLS Handshake process when the Cipher Suite is negotiated.

The sender will then encrypt the data payload using the symmetric key (as described earlier in the Encryption section), encapsulate it into a TLS record, and pass this record down to the Transport layer to be sent to the other party.

Upon receipt of the message, the receiver will decrypt the data payload using the symmetric key. The receiver will then also create a digest of the payload using the same algorithm and hash value. If the two digests match, this confirms the integrity of the message.