+++
title = "Stream ID error in Go"
date = "2026-02-23T18:00:00+02:00"
description = "Causes for getting Stream ID error for HTTP requests in Golang"
tags = ["go"]
+++

When connecting to another service for sending GraphQL queries (both client and server in Go), we were getting this error: `stream error: stream ID 3; INTERNAL_ERROR; received from peer`

Problem is that after searching, I couldn't any good explanation on the cause of this error. In one GitHub issue thread it was even suggested to switch from WLAN to LAN to fix the problem.

The way we solved the issue in our system was by retrying failed requests with back-off time. The cause of the issue still remained unknown.

So I decided to take a deeper look into it: I checked the Go source code to see when this error is thrown. I found one occurance of `stream ID` in the code, which was in a test case [here](https://github.com/golang/go/blob/4e693d1ec52c86b262ac23f0d6cee6b60fef4fb0/src/net/http/serve_test.go#L1094).

If you check the code you can see how it's set up: Two HTTP requests are sent. The second one timed out. With that, if we're in HTTP2 mode, we will get this error: `stream ID 3; INTERNAL_ERROR`

Why 3? Because stream number in HTTP specification mandates even numbers for server and odd numbers for client stream:

> Streams are identified with an unsigned 31-bit integer.  Streams initiated by a client MUST use odd-numbered stream identifiers; those initiated by the server MUST use even-numbered stream identifiers.

Then what the error tells us is that second client-initiated stream was failed due to some internal error on the server (in the case of the test in Go code, time out)

### Solution:

- On the client side: Retry with back-off time
- On the server side: Figure out why handling the connections fails (context deadline exceeded? time out?)

Please let me know if you also faced the similar issue and how you handled it.  
Hope it helps.
