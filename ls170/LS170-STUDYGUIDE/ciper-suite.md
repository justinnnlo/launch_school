Cipher Suites
During the description of the TLS Handshake, we mentioned Cipher Suites a few times. So what exactly is a Cipher Suite?

A cipher is a cryptographic algorithm; in other words they are sets of steps for performing encryption, decryption, and other related tasks. A cipher suite is a suite, or set, of ciphers.

TLS uses different ciphers for different aspects of establishing and maintaining a secure connection. There are many algorithms which can be used for the performing the key exchange process, as well as for carrying out authentication, symmetric key encryption, and checking message integrity.

The algorithms for performing each of these tasks, when combined, form the cipher suite. The suite to be used is agreed as part of the TLS Handshake. As part of the ClientHello message, the client sends a list of algorithms it supports for each required task, and the server chooses from these according to which algorithms it also supports.

