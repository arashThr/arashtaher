---
date: "2025-02-01T12:14:31Z"
tags:
- css
- docker
- web development
title: Build Tailwind v4 locally with Docker
---

I had some issues setting up Tailwind v4 build locally with Docker.

## Key Changes from Tailwind v3

First, it was all the changes from version 3:

- No more `init` step: Running the `init` command will get you an error
- No need for `tailwind.config.js` file

## Source Path Issue

Main changes from earlier versions are covered in this discussion on Tailwind's GitHub page: "[Beginner tutorial for setting up tailwind v4 using the standalone CLI](https://github.com/tailwindlabs/tailwindcss/discussions/15855)"

Recommended is to add `source("../")` to the import, so Tailwind knows where to find the files.

## Root Directory Bug

But even doing that, I had issues building the CSS file.

As it turned out, there was a bug in Tailwind which was causing the issue and was addressed here: [Fix `resolve_globs` crash when at root directory](https://github.com/tailwindlabs/tailwindcss/pull/15988)

Basically, the build process was crashing when the build took place in root.

## Changing Working Directory

By checking the tailwind CLI options, I found out about the `cwd` option. It lets you change the working directory where the command looks for files.

By adding that, I removed the `source` from the CSS file.

## Working Solution

Putting it all together, here's my `style.css` and `Dockerfile` for building Tailwind locally:

```css
/* style.css */
@import "tailwindcss";
```

```dockerfile
# Dockerfile
FROM node:alpine
WORKDIR /tailwind
RUN npm init -y && npm install tailwindcss @tailwindcss/cli

CMD npx @tailwindcss/cli --cwd /templates -i /src/style.css -o /dst/style.css --watch
```