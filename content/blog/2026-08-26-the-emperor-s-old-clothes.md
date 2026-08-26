+++
title = "Agents and The Emperor's Old Clothes"
date = "2026-08-26T18:08:00.000Z"
tags = [ ]
+++

With the emergence of AI, I find myself going back time and time again to fundamentals.

As a consequence, I realized these days papers and books have become a substantial part of my daily studies.

In the following posts I'll share some of the best ones I've read.

The first one is a paper from 1981 by Hoare. The title of the paper is "[**The Emperor's Old Clothes**](https://www.labouseur.com/projects/codeReckon/papers/The-Emperors-Old-Clothes.pdf)".

It's 50 years old, but I'm not exaggerating when I say *I found some of the best insights about the limitations and capabilities of agentic coding in it*!

These old papers have an essence in them, which is their focus on first principles. It's as if they were looking at the problems like math puzzles, and they were trying to prove the correct way to build systems. That way of looking at obstacles gives these older works a timeless, never-aging quality.

One thing that I'm thankful about AI is that it finally gave me the time and freedom to switch my attention from the latest JS framework to the core limitations that have been here for a long time. Exactly like the one discussed in this paper.

The paper goes through Hoare's experience with one of his biggest failures working on the Elliott 503 Mark II software system, which was "a range of operating system software for larger configurations of the 503 computer". They started their project after the massive success of their compiler implementation of ALGOL 60.

He was promoted to "Assistant Chief Engineer", and they set a deadline for delivery some eighteen months ahead.

They hired some of the best engineers (whom I'd like to consider as agents in our 2026 world) and started working on the project.

**Long story short, the project failed miserably**. After postponing the deadline two times, they realized that their application was practically impossible to run: "It turned out that we had failed to make any overall plans for the allocation of our most limited resource, main storage."

**But how did this happen?** How could one of the brightest computer engineers who ever lived have missed something so obvious?

And here's the most interesting part of the paper for me, when "the most senior manager of all" pays him a visit to tell him about what went wrong:

> "You know what went wrong?" he shouted—he always shouted—"**You let your programmers do things which you yourself do not understand**."
>
> I stared in astonishment. He was obviously out of touch with present-day realities. How could one person ever understand the whole of a modern software product like the Elliott 503 Mark II software system?
>
> I realized later that he was absolutely right; he had diagnosed the true cause of the problem, and he had planted the seed of its later solution.

The rest of the paper describes their way out of this mess, which practically laid the foundation for principles of simplicity and sound design in software engineering.

I really loved it: "You let your programmers do things which you yourself do not understand."

If we replace "programmers" with "agents" we can get some interesting insights about agentic programming in year 2026: Yes, your tiny vibe-coded application will work perfectly (exactly like when you can describe it to a seasoned programmer), but **scaling the application needs an understanding of the challenges you solved in every single layer**.

Thinking can be delegated, but understanding the interactions between the systems, and most importantly, the constraints and limitations of the environment, is what determines the success or failure of a large project.

Transcending above solving the immediate matter and looking at the whole picture, while you have all the details in mind, will be the real challenge. (Yes, I came up with the word "transcend" myself, without using AI.)

One last lesson from Hoare: **don't try to be smart**. "You know, you shouldn’t trust us intelligent programmers. We can think up such good arguments for convincing ourselves and each other of the utterly absurd."