---
date: "2019-07-28T09:56:25Z"
title: How to write your first Firefox add-on?
---

> Due to U.S. trade controls law restrictions, your GitHub account has been restricted.

This is the message that's been recently sent to Iranian developers from GitHub, stating their accounts have been restricted.

The political reasons and consequences of this action are not what I'm going to talk about (this is not the right place). Instead, I'm going to focus on what happened after this announcement to the GitHub site: A horrendous yellow banner, screaming our misfortunes on top of every GitHub page:

![github](/wp-content/uploads/2019/07/github-1.jpg)

So I thought this might be a good time to try writing my first add-on for Firefox. It seemed like a trivial task, and I was curious how much time it was going to take. Simple tasks must be simple to do.

At first, I tried to remove the banner in the browser inspector. All I had to do was set the `display` property to `none` for the element, and it was gone.

So, that's what we want our add-on to do: To simply set a CSS property for an element.

### Write the extension

MDN web docs have a page called [Your first extension](https://developer.mozilla.org/en-US/docs/Mozilla/Add-ons/WebExtensions/Your_first_WebExtension), and I followed the steps it said:

At first, I created a directory for my add-on.

Then I created a `manifest.json` file. This file is the skeleton of your extension; it includes what files it contains, a short description, extension version, icons, and everything else.

The `content_scripts` section is the most interesting part: You define in what domains, which scripts must be injected.

I wanted to modify the appearance of GitHub, which means all I wanted to do was to add a CSS property. So I modified `content_scripts` in `manifest.json` to look like this:

```json
"content_scripts": [
  {
    "matches": ["*://*.github.com/*"],
    "css": ["github-warn.css"],
  }
]
```

And in `github-warn.css` I wrote this:

```css
div.position-relative.js-header-wrapper > div.js-notice.flash-warn {
    display: none;
}
```

### Run and debug

Now let's test the add-on. First, we must load it into the browser. To do so, go to `about:debugging`.