---
title: "Finish What You Started"
date: 2026-02-24T11:16:43+01:00
draft: true
---

In the never ending series of errors I see in the logs and the bugs I find in the code, the majority of them are the result of not finishing what you started.

When I say "finishing", I'm not talking about refactoring the code to make sure the design is elegant, I'm not even discussing the importance of automated testing and making sure there's full coverage on every single line of code. My point is, running the code, checking if it works as expected, and then (here's the important part): thinking about whether it's actually doing what it's supposed to do, and whether it does it reasonably.

If we were architects, I'd like to think about it as taking a final look at the house you've built from far away.

Here are some examples of the different aspects that you can consider after you're done with a task:

- Can I easily test it, whether automated or manually?
- What can cause errors? Is there a way to gracefully handle them?
- Is it fast enough? Are the tests running fast?
- How many API calls does it make? Does it need to do it?
- Is there a possibility of race conditions?
- If things stop working, how will I figure it out? (Will I figure it out?)

Ask yourself these simple questions before calling it done. That would make life way easier.

Leave comments on [X](https://x.com/rshthr/status/2026239483100742004)
