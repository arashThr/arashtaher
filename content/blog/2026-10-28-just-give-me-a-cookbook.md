---
title: Just give me a cookbook
date: 2026-10-28T10:19:54.904Z
tags:
  - infra
  - documentation
  - engineering
  - software
---

One of the biggest problems I have working in a big company is the amount of documentation, and the expectation that everyone has the time, energy, and mental bandwidth to go through *very detailed documents*.

In many cases I just want a **step-by-step guide**. Give me a clear and concrete layer of abstraction on top of what you’ve built, and let me use it. I don’t need to know how your system handles configuration, or what the topology of the architecture looks like. Just give me a cookbook I can follow so I can get the thing I need to do done.

**This is especially true with infrastructure teams**. The problems they solve are genuinely difficult, and they see a lot of value in that difficulty. Some of that excitement finds its way into the documentation, and now I have to read a large amount of text explaining why Kubernetes is so stable and robust. As someone focused on the application layer in my role at the company, I mostly just want the thing to work.

I think this is also one of the reasons there’s **so much hesitation around building user interfaces for infrastructure**. Why do I have to edit YAML and JSON files and create a commit in a repository? Give me a clean interface with limited options so I can follow a clear path and get the thing done. **You can and should always provide the detailed documentation later for the people who need it. Most of the time, I shouldn’t have to start there.**

Writing good documentation is an art. You can’t reasonably expect most software engineers to be good at it.
