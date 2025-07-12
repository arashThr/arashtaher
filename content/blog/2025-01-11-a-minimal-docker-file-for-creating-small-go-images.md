---
date: "2025-01-11T15:54:39Z"
tags:
- Go
- Docker
- Programming
- Technology
title: A minimal docker file for creating small Go images
---

Here's simple Docker file for building small Go images. It uses a multi-stage build to create a minimal runtime image with only the necessary files.

```
FROM golang:1.17-alpine3.15 AS builder
WORKDIR /app
COPY go.mod go.sum ./
RUN go mod download
COPY . .
ENV USER=appuser
ENV UID=10001
RUN apk update && apk upgrade && \
    apk add --no-cache git ca-certificates tzdata && \
    update-ca-certificates
RUN adduser \
    --disabled-password \
    --comments "" \
    --home "/nonexistent" \
    --shell "/sbin/nologin" \
    --no-create-home \
    --uid "${UID}" \
    "${USER}"
RUN CGO_ENABLED=0 go build -ldflags \
    '-w -s -extldflags "-static"' \
    -a -o application main.go
# Runtime stage
FROM scratch
ENV USER=appuser
COPY --from=builder /etc/passwd /etc/passwd
COPY --from=builder /etc/group /etc/group
WORKDIR /app
COPY --from=builder /app/application ./
USER appuser
ENTRYPOINT ["./application"]
```

Timezone and ca-certificates can be dropped if:

1. Only UTC timezone is used in the application
2. No HTTPS or SSL/TLS connections are required