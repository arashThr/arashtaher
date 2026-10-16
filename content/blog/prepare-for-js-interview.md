+++
title = 'Prepare for Node.js Interview'
date = '2026-10-16T11:56:30+02:00'
tags = ["js", "ts", "programming", "interview"]
+++

A friend of mine asked about how to prepare for a JavaScript/TypeScript/Node.js interview. Here's the summary of what I'd recommend.  
This is a compact list and not comprehensive in any sense. Just a guideline **if you have a couple of days** to prepare for an interview.

## Syntax
Refresh your memory on syntax. Nothing crazy. Skimming [Learn X in Y Minutes](https://learnxinyminutes.com/javascript/) would suffice.  
Write down notes and try statements in the REPL.  
For JavaScript, it's also good to review [WTFs](https://github.com/denysdovhan/wtfjs) if you have time.

## Practice
Next step, if you have the time, go through a series of challenges to make sure you're comfortable with the syntax. Once you can easily write simple constructs in the language, move to the runtime.  
Best resource for this step is a curated one, and you can and should use AI for that. For example, for Go, I made a series of [challenges](https://github.com/arashThr/Playground/tree/master/go/challenges) to practice different aspects of the language. It should be fairly straightforward to produce something similar for JS.  

First few exercises should focus on JS and TS syntax: *control flows, classes and prototypes, interfaces, serialization, IO, async, etc.*

After that, shift the focus to understanding Node's internals: *the event loop, streams, worker threads, error handling...*

Depending on how much time you have, you can spend as much time as you need here.
If you have time, I'd also recommend going through a series of DSA problems on LeetCode to warm up your brain for these sorts of problems.

## Build
Build the skeleton of a web application in Node.js. Things are moving fast in the JS world. As dumb as it is, scaffolding a project is not trivial. You have to fix the module type, set up TypeScript, a linter, a formatter, migrations...

In my opinion, it is also **critical to do this step yourself before handing things over to AI**. Make the decisions on whether the system should use ORMs or SQL, how you want to run the application using Docker, which web framework to use, and how to run the tests.

This is the step to question the defaults suggested by AI. For instance, if you go with the default recommendation of AI for testing, you might end up dealing with Jest, but now we have [node:test](https://nodejs.org/api/test.html) that we can use, which makes things simpler.

Recently I was working on setting up such a project. You can check out the initial commit with all the configurations and decisions for the foundation of the application in [this commit](https://github.com/arashThr/qred-case/commit/3d664ca9485fbceea1cc6641e58145fe7f103092).

Three critical components in this step to spend time on are setting up databases, creating auth, and background workers. If you have time, it's nice to lay the foundation for these at this point.

## Extend
This is where AI comes in and where you need to push the code and functionalities to the edge. Build X, Netflix, Amazon... Just get on your favorite harness and dispatch those agents to work. It is more and more expected from an engineer to deliver a product, so it's becoming an integral part of the interview process to show that you can get those agents to build a scalable, functional, and secure system.

This is outside the scope of this post, which is for a Node.js interview, but if you're interested you can find out more about this in Karpathy's blog post: [Hiring Should Change](https://karpathy.bearblog.dev/sequoia-ascent-2026/).
