---
date: "2025-05-13T18:07:00Z"
tags:
- browser
- javascript
- programming
title: Content Scripts Not Loading for JSON Pages in Firefox
slug: hello
---

Ran into a weird issue where my content script wasn’t loading for a page in Firefox (Manifest V2). Worked fine in Chrome (Manifest V3). Turns out, Firefox only injects content scripts into HTML pages, not JSON responses (Content-Type: application/json). Makes sense—content scripts need a DOM, and JSON doesn’t have one.

I didn't find this problem to be mentioned anywhere else, so here's a quick blog post to explain it.

I was trying to grab a JSON token from `http://localhost:8000/extension/auth` and send it back to my extension. Chrome handled it, but Firefox just wouldn’t run the script.

## Fix: Swap JSON for HTML

Instead of a raw JSON response, I made the server return an HTML page with the response now in a hidden form field.

Here's the initial version of the `content.js` file:

```javascript
const response = document.body.textContent;
try {
  const data = JSON.parse(response);
  if (data.token) {
    // Send the token back to the options page
    chrome.runtime.sendMessage({
      type: "TOKEN",
      token: data.token,
    });
  } else if (data.errorCode) {
    console.error("Error from auth response:", data);
  }
} catch (e) {
  console.error("Failed to parse response:", e);
}
```

And now, instead I serve HTML and get the token from the hidden field in form:

```javascript
(function() {
  // Try to find the token immediately
  let tokenField = document.getElementById('token');
  
  // If not found, set up a small delay to try again
  // (in case our script runs before the element is available)
  if (!tokenField) {
    setTimeout(function() {
      tokenField = document.getElementById('token');
      if (tokenField && tokenField.value) {
        chrome.runtime.sendMessage({
          type: "TOKEN",
          token: tokenField.value,
        });
        console.log("Token found and sent (delayed)");
      }
    }, 500);
  } else if (tokenField && tokenField.value) {
    chrome.runtime.sendMessage({
      type: "TOKEN",
      token: tokenField.value,
    });
    console.log("Token found and sent (immediate)");
  }
})();
```

## Why It Works

The HTML response lets Firefox run the content script, and the hidden field holds the JSON. Works in Chrome too. If you can’t change the server, you could use webRequest in the background script, but this felt cleaner.

## Takeaway

Firefox won’t run content scripts on JSON pages. Serve HTML instead. It's a better solution anyway. It's strange to serve JSON to the user!