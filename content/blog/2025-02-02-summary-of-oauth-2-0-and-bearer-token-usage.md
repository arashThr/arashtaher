---
date: "2025-02-02T20:54:49Z"
tags:
- API
- Auth
- Authentication
- Cloud
- HTTP
- OAuth
- Programming
- Security
title: Summary of OAuth 2.0 and Bearer Token Usage
---

Here's a summary of my notes regarding OAuth 2.0, access and bearer token, and their usages.  
Links and references at the end.

---

HTTP authentication header: `Authorization: <type> <credentials>`

Authentication schemes:

- Basic: base64-encoded credentials
- Bearer: bearer tokens to access OAuth 2.0-protected resources (Give the bearer of this token access)

The bearer token is a type of access token, which does NOT require PoP (proof-of-possession) mechanism.

RFC 6750 describes how to make protected resource requests when the OAuth access token is a bearer token.

RFC 6749 covers main auth flows, called grants.  
An OAuth grant is a specific flow that results in an access token.  
Access token (most of time Bearer) is the end product of a grant auth flow in OAuth.

RFC 7519: JWT

Access token is like a currency note e.g 100$ bill . One can use the currency note without being asked any/many questions:

- Access token = payment methods
- Bearer token = cash

In OAuth 2, when user requests to the server for a token sending user and password through SSL, the server returns two things: an Access token and a Refresh token:

```json
{
  "access_token": "AYjcyMzY3ZDhiNmJkNTY",
  "refresh_token": "RjY2NjM5NzA2OWJjuE7c",
  "token_type": "bearer",
  "expires": 3600
}
```

Presence of refresh token mean the access token will expire.

This access token, is of type bearer and *can* be JWT token, because the server can make decisions based on whats inside the token

**Tokens vs. API keys**

User-specific authentication is a hallmark of bearer token usage

API keys are used for identifying and authenticating the application or client rather than an individual user. It's static and the scope of a set of APIs.

With API kets expiration happens manually.

API keys define the source of the requesting entity, whereas API tokens identify the user and their rights.

**Implementing Bearer Tokens**

Example: Generating a JWT bearer token:

```js
// Generate and issue a bearer token
function issueToken(userId) {
  const token = jwt.sign({ userId }, 'your-secret-key', { expiresIn: '1h' });
  return token;
}
```

Middleware to use the token:

```js
// Middleware for bearer token authentication
function authenticateToken(req, res, next) {
  const authHeader = req.headers['authorization'];
  const token = authHeader && authHeader.split(' ')[1];

  if (!token) {
    return res.sendStatus(401);
  }

  jwt.verify(token, 'your-secret-key', (err, decoded) => {
    if (err) {
      return res.sendStatus(403);
    }

    // Add the decoded information to the request object
    req.user = decoded;
    next();
  });
}

// Protected route
app.get('/api/protected-resource', authenticateToken, (req, res) => {
  // Access the user information from req.user
  const userId = req.user.userId;
  // Fetch the protected resource and send the response
  res.json({ message: `Protected resource accessed by user ${userId}` });
});
```

### Links and refernces

<https://stackoverflow.blog/2022/12/22/the-complete-guide-to-protecting-your-apis-with-oauth2/>

<https://datatracker.ietf.org/doc/html/rfc6749>

<https://www.oauth.com/oauth2-servers/making-authenticated-requests/>

<https://stackoverflow.com/questions/25838183/what-is-the-oauth-2-0-bearer-token-exactly>

<https://medium.com/@arunchaitanya/wtf-is-bearer-token-an-in-depth-explanation-60695b581928>