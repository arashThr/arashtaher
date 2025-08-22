+++
title = "Switching from Cursor to Claude CLI"
date = "2025-07-27T13:08:48+02:00"
tags = ["ai", "llm", "pensive"]
+++

For the past month, I've been working on the [Pensive project](https://getpensive.com/), and I've been using Cursor. It's a great tool for rapid iteration and trying out different things, especially on the front end. I was constantly tweaking the way content was presented, and Cursor made it easy. I didn't have to spend too much time on styling and appearance.

However, I've reached a point where Cursor feels a bit intrusive. I don't like how it interacts with the backend code, especially when I'm trying to keep things organized and clean. For larger refactoring tasks, it's not ideal either. It tends to iterate and make changes that I could easily do myself. I much prefer the "ask" functionality for specific questions, and I mainly use the agent mode for front-end or website appearance tweaks.

Now, I'm switching to Claude CLI for a few reasons. First, they're doing some really interesting things. I just discovered their agents and I'm eager to try them out. Also, I found other sources with similar idea as what I discovered in my [previous post]({{< ref 2025-07-18-ai-documentation >}}) about providing context for AI agents. [Here's](https://getstream.io/blog/cursor-ai-large-projects/) a great post on it in Stream project blog, and of course it turns out Claude's agents can create markdown files to serve as context.

In a recent [interview](https://lexfridman.com/dhh-david-heinemeier-hansson/) with Lex Fridman, DHH mentioned the idea of a coding agent as a pair programmer, which resonated with me. I've already disabled autocomplete in Copilot because I dislike the stop-pause-wait cycle – it disrupts my flow. I'm excited to see how Claude works out. I'll keep you posted!
