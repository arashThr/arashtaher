---
date: "2021-07-20T08:07:40Z"
tags:
- async
- javascript
- programming
title: Recursive asynchronous function call
---

One of the well-known Redis clients for NodeJS is `ioredis`. When I was trying to work with Redis streams using this library, I used the example they provide on their GitHub page. When I read the code, I noticed that to constantly listen for new messages, they have used a recursive call to an asynchronous function:

```javascript
async function listenForMessage(lastId = "$") {
  const results = await redis.xread("block", 0, "STREAMS", "mystream", lastId);
  const [key, messages] = results[0]; // `key` equals to "mystream"

  messages.forEach(processMessage);

  // Pass the last id of the results to the next round.
  await listenForMessage(messages[messages.length - 1][0]);
}

listenForMessage();
```

The `XREAD` function blocks the execution until we receive another message in the stream; then it recalls itself to get another message on the stream.

My question was if this is a safe approach to iterate over the messages we receive; specifically, I was interested to know whether we'll have a stack overflow over time, or some mechanism like [tail call optimization](https://en.wikipedia.org/wiki/Tail_call) will take care of the growing stack.

To check this, I simply logged the stack after each call: `console.trace()`

And then I ran the code and started adding items to the Redis stream in one-second intervals:
`redis-cli -r -1 -i 0.2 xadd mystream '*' item 1`

In this way, you can see the stack trace, and it becomes obvious that function calls pile up; every function call will wait for the return value of the previous one, and it will lead to a memory leak.

By the way, don't forget to set the stack trace limit when running the program, otherwise, you'll see only 10 frames: `--stack_trace_limit=200`

### How to solve it?

Just don't `await` on the function call! You don't need the result, and by letting the current execution be finished, the stack frame can be released.