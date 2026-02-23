+++
title = "Closing Response body in Go is not enough"
date = "2025-11-04T16:00:00+02:00"
description = "Sharing a personal lesson on resource management when it comes to Go's HTTP responses"
tags = ["golang", "http", "programming", "tips"]
+++

I just published my side project in Go as open source: Pensive, a full-text searchable bookmarking service.

It lets you save articles and search inside their content, not just titles.

Visit it at https://getpensive.com

---

Did you know closing the Response body is not enough to reuse the connection and you also need to **read the body**?

We had some issue regarding our HTTP requests, and after some investigations I found out about this in [Response](https://pkg.go.dev/net/http#Response) docs:

> If the Body is not both read to EOF and closed, the Client's underlying RoundTripper (typically Transport) may not be able to re-use a persistent TCP connection to the server for a subsequent "keep-alive" request.

Meaning you'll have a bunch of sockets in the `TIME_WAIT` state. Subsequently, in HTTP/2 this can case cause connection issues due to flow control.

Also in [Go code](https://pkg.go.dev/net/http#Response) you can see that reading the body is required even if you close the body:

> The http Client and Transport guarantee that Body is always non-nil, even on responses without a body or responses with a zero-length body. It is the caller's responsibility to close Body. The default HTTP client's Transport may not reuse HTTP/1.x "keep-alive" TCP connections if the Body is not read to completion and closed.

Which in practices means:

```go
resp, err := http.Get("http://localhost:8080/")
if err != nil {
  panic(fmt.Sprintf("Got error: %v", err))
}
io.Copy(io.Discard, resp.Body) // Add even if you don't read the body
resp.Body.Close()
```

[Here](https://tleyden.github.io/blog/2016/11/21/tuning-the-go-http-client-library-for-load-testing/)'s a nice blog post about this issue with a good example to reproduce the problem.
