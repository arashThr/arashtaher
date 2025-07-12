---
date: "2012-07-27T00:09:23Z"
tags:
- concurrency
- os
- programming
- python
title: A simple scheduler in Python
---

Here's a simple scheduler simulator in Python that you can download from [here](http://ge.tt/27PfW5L/v/0?c "Scheduler simulator in Python"). You give it a list of processes and scheduling algorithm you want to be used for scheduling and as result you get a simple output like this which shows you the sequence of the processes running in intervals:

```
System starts up
002.000: Algorithm SPN is in use
004.000: Process 001 Created
004.000: Process 001 -> readyQ
004.000: Process 001 -> CPU
006.100: Algorithm MLFQ is in use
007.300: Process 002 -> swapped out
```

![It's all about perfect timing](http://lifewithoutbuildings.net/wordpress/wp-content/uploads/2009/09/chaplin_3.jpg)

This program is interesting in several aspects:

- Firstly, it helps you to grasp ideas behind scheduling algorithms in OS.
- Secondly, it takes advantage of threading to simulate IO operations.
- Also, it reads its input from an XML file, worth taking a look.
- And finally, it's in Python.

Unfortunately, because of lack of enough time for this project, it's not as beautiful as I liked, but as a proverb says, "Something is (most of the times) better than nothing."