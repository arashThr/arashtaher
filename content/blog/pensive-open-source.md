+++
title = "Publishing Pensive as Open Source"
date = "2025-08-18T23:36:57+02:00"
description = "I have published my personal project, Pensive, as open source. Here's the story of it on the tech side"
tags = ["pensive", "project", "go", "htmx", "react"]
+++

I just published my side project in Go as open source: Pensive, a full-text searchable bookmarking service.

It lets you save articles and search inside their content, not just titles.

Repo: https://github.com/arashThr/pensive

---

Why Go? Honestly, if it wasn’t for Go, I don’t think I would’ve ever finished this thing.

The story goes like this:

Pocket’s search sucked. Really sucked. I just wanted to save Hacker News articles and be able to find them later, not scroll through 500 “Why I quit Google” posts.

So I thought: “I’ll build my own.”

## Attempt #1: TypeScript

I use TypeScript every day at work. Should be easy for a side project, right? Wrong.

Configuring tsconfig, fighting ESLint, imports vs requires, deprecation warnings… it felt like trying to adopt a cat that keeps scratching you.

And once it finally ran, the types themselves were in my way. I like types! But in TypeScript, they felt like paperwork from HR: technically useful, practically exhausting.

So I gave up and renamed everything from .ts to .js. Suddenly life was better. No build step, no extra annotations — just write code and run it.

## But then… frameworks.

I knew if the project grew, I’d need batteries included. So I looked around: Nest, Sails, Adonis, Loopback, Next…

Too many. All shiny, all “the future,” all “coming soon.”

I remembered my last “future-proof” project: MEAN.js. Angular.js was the king, Bower was hot, Grunt was the cool build tool. And today? Archaeology.

That was the moment I almost quit. I thought: This is not for you. You have a job. You’ll never finish this.

## Then Go entered the chat.

Go was… different. Simple, straightforward, unpretentious.

Coming from Perl’s “There’s more than one way to do it,” Go’s “There’s exactly one way to do it” felt like therapy.

No JVM, no CLI gymnastics. Deploying was laughably easy.

And reading Go code? Like reading short stories. With JavaScript I need pen and paper just to trace what’s happening. With Go, I could just… read. And understand.

That gave me confidence. For the first time, I felt like I might actually finish this thing.

## But wait, what about React?

Yeah, I saw it at the end of the tunnel. Don’t get me wrong, I like React. It does magic.

But did I want magic in my small humble project? Nope. I just wanted code I could understand when I woke up in the morning.

## Enter HTMX.

Yes, I fell for the memes. Call me lame, but it worked. And surprisingly, the hypermedia philosophy made perfect sense to me.

HTMX is small, witty, cool. And honestly… I wanted to be cool too. Why else do a side project?

---

At the end of the day, side projects are for learning and for fun. That’s what Go gave me: joy. It made me want to add one more feature, then another.

So here it is: Pensive.
Check it out, open a PR, and tell me how I did it wrong; I’d love to learn.

👉 https://github.com/arashThr/pensive

