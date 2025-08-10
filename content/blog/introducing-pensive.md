+++
title = "Introducing Pensive: Building a Searchable Memory for the Web"
date = "2025-08-10T11:06:52+02:00"
description = "I have launched a bookmarking application called Pensive. In this post I tell the story of why I decided to build this application, where you can find it, and I also share some of the technical decisions I made along the way"

tags = ["project","bookmarking","llm","ai"]
+++

___Summary:___ I built [Pensive](https://getpensive.com) as a tool to preserve and search my online discoveries. It integrates with Telegram and has a browser extension for easy saving. It uses Go, HTMX, PostgreSQL, and Gemini Flash for AI features.

---

A few years ago, I stumbled upon Microsoft's [MyLifeBits](https://en.wikipedia.org/wiki/MyLifeBits) research project. The idea was simple yet profound: document everything in your life and make it searchable. Gordon Bell, the test subject, had his entire life indexed - every document, photo, and interaction.

That concept haunted me. Not because I wanted to record everything, but because I realized how much valuable knowledge I was losing online.

## I can see myself losing it

I read constantly. Hacker News, technical blogs, random fascinating articles. I also love sharing these discoveries with friends when the topic comes up, and I'd like to refer them to the source. But finding these articles again, especially if they're not featured on HackerNews and other well-known websites, is quite difficult. I have developed the habit of bookmarking these pages, but good luck finding that incredible article about [mechanical watches](https://ciechanow.ski/mechanical-watch/) with interactive animations that is now lost among 2,847 other bookmarks.

Google search became useless! Drowning in SEO-optimized content farms, Quora spam, WikiHow articles and GeeksforGeeks nonsense. The personal web, those beautiful individual voices that teach you how to build your own [text editor](https://viewsourcecode.org/snaptoken/kilo/), buried under corporate content.

I tried different solutions. Pocket was good, although the search was terrible. But after it was acquired by Mozilla, it was slowly transformed into another recommendation engine with ads. There are other great alternatives like Instapaper and Inoreader, but I felt like I had enough unique requirements to consider building my own solution.

## Enough is enough

So I built Pensive. Here's what mattered to me:

**Integration over isolation**: I use Telegram constantly. Why install another app? Pensive works through a Telegram bot - just forward links. On desktop, a simple browser extension.

**Content over metadata**: When I search for "compound interest," I want to find that finance article even if it was titled "Money Tips #47." Pensive indexes full content, not just titles.

**Modern tools, simple stack**: This project became my playground for exploring how AI changes development. I used:
- **Go** for the backend - its simplicity is perfect for a sustainable side project
- **HTMX** instead of React/Vue - server-side rendering that I can maintain in 5 years
- **PostgreSQL** with full-text search - boring technology that works
- **Gemini Flash** for AI features - summaries, tags, and markdown extraction (Inspired by [Spegel](https://simedw.com/2025/06/23/introducing-spegel/))

## On the tech side

One of the reasons I started building Pensive was because I was looking for a real-world project to practice Go. I started programming in Go in the past year and it's been an amazing experience. Previously, I had worked on real-world projects with Java, TypeScript, React, and even Perl. So learning a new language at work was not something new to me. But getting into Go felt like coming home. One great source that I can recommend if you're new to Go (after going through the Tour of Go, of course) is Jon Calhoun's [Web Development with Go](https://www.usegolang.com/) course. It was really helpful to build a real, big project while someone with more expertise in the language was there to help you do it in the most idiomatic way.

HTMX deserves special mention. Many years ago, for one of my [side projects](https://github.com/arashThr/partalk/), I was advised to use AngularJS. Try running that today! With HTMX, I control everything from the server. No build steps, no deprecated frameworks. Just HTML over the wire.

But the most profound experience was working with AI tools (Copilot, Cursor, Claude). It has transformed my productivity drastically. The entire MVP took less than a month, far exceeding my expectations. I'm convinced that companies who are not changing their mindset and workflows to adapt to this new world with AI are going to suffer the consequences severely.

## What's Next

Pensive is live and I use it daily. You get:
- 10 free saves/day (100 for premium)
- Full-text search across everything you've saved
- AI summaries and auto-tagging
- Clean markdown extraction
- Pocket import

Is it perfect? No. It's beta software built by one person. But it solves my problem, and maybe it'll solve yours too.

Try it at [getpensive.com](https://getpensive.com). Install the [Chrome extension](https://chromewebstore.google.com/detail/pensive-save-search-what/klmginbbicjdpaodcbokdjbhnbaocomd), [Firefox addon](https://addons.mozilla.org/en-US/firefox/addon/pensive/), or message [@GetPensiveBot](https://t.me/GetPensiveBot) on Telegram.

Hopefully, it will be a quiet corner where we can build our own libraries of the web, away from the algorithm-driven noise.

[Let me know what you think](/contact/)
