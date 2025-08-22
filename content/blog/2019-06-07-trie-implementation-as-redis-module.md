---
date: "2019-06-07T21:26:27Z"
tags:
- csharp
- database
- redis
title: Trie implementation as Redis module
---

In this post, I'm going to explain how I implemented the Trie data structure in C++ and imported it as a new data type into Redis.

I start with the implementation of Trie in C++ (how I got started and how I tested the code), and then go into the details of introducing the Trie as a new data type to Redis. (By the way, there's already a Trie module implementation in C available which you can check out [here](https://github.com/cmsc22000-project-2018/redis-tries).)

## Trie data structure

GeeksForGeeks has proven over the years that it's the best source to learn or refresh my mind on all sorts of algorithmic problems. So I [headed over to it](https://www.geeksforgeeks.org/trie-insert-and-search/) and as I was going forward, I also started the implementation. After a couple of minutes, I had `insert` and `search` functionalities.

### Test it!

It had been a long time since I had my hands on C++ code, and as a TDD fanatic, I had to have automated tests for my Trie.

After a brief search, I found three candidates:

1. [Google tests](https://github.com/google/googletest)
2. [Boost.Test](https://www.boost.org/doc/libs/1_66_0/libs/test/doc/html/index.html)
3. [Catch2](https://github.com/catchorg/Catch2)

The first two are both mature and filled with all sorts of features, which meant they had their own subtleties. Also, considering the size of my tiny project, they were somehow huge. I wanted something simple and clean, so I could just drop it in my project and use it; and there it comes, Catch2. It came to my attention after seeing it mentioned on [SO](https://stackoverflow.com/questions/242926/comparison-of-c-unit-test-frameworks) and [Reddit](https://www.reddit.com/r/cpp/comments/36pru0/best_way_to_do_unit_testing_in_c/).

> A modern, C++-native, header-only, test framework for unit-tests, TDD, and BDD

It's header-only, simple to use, and the documentation is clear. You just put the header file in your project and reference it in your test file. I could use it immediately. Now I had my automated tests.

### Trie.remove

Implementation of `insert` and `search` was fairly simple; `remove` was a little bit more interesting. The reason was that when there are no more keys in the node, you have to delete the node. Then you have to move up and check the same thing for the node's parent, because if it was created just for that specific key, the delete operation must take place over and over until you reach the root.

Note: One thing that I have not implemented yet and would be good to have is to return a value denoting whether the key was deleted from the Trie or not (which means it didn't exist in the first place).

### Edge cases

Just make sure you're giving the proper index number to characters you want to save in Trie; numbers, uppercase letters, and punctuation marks.

## Redis modules

First, when I was asked to write a Redis module, I thought of Lua scripts that made it possible to write extensions for Redis. Redis modules are a totally different beast. These are C shared libraries that you can load at runtime or startup. They let you define new commands or new types in the Redis core. To know the exact differences, I suggest reading this [blog post](https://redislabs.com/blog/writing-redis-modules/) on the RedisLab site.

This post is also the perfect place to start writing your first module. Follow the steps and you have your new Redis command, `HGETSET`; a dummy command that lets you get and set a key at the same time. Fortunately, compiling Redis modules requires no special linking. Just add `redismodule.h` to the project and you're ready to go.

### Define new types

RedisLab sample, which is the same as the [Redis Module SDK](https://github.com/RedisLabs/RedisModulesSDK) sample program, both show how to add a new command to Redis and none of them define a new type. Delving into documentation with no concrete example was a futile effort for me, so I looked for code samples. The best one I found was the `HelloType` sample in the [Redis repository](https://github.com/antirez/redis/blob/fc0c9c8097a5b2bc8728bec9cfee26817a702f09/src/modules/hellotype.c). The other one was another [implementation of Trie in C](https://github.com/cmsc22000-project-2018/redis-tries). By looking at the code and visiting documentation, you could easily figure out how to manage memory and allocate space to your data type.

### C vs. C++

Redis modules are supposed to be written in C and loaded as shared libraries. In order to use C++ for writing modules, all you have to do is to add `extern "C"` at the beginning of `RedisModule_OnLoad` to make it visible to Redis.

## Code

You can check out the final result in this [Github repository](https://github.com/arashThr/trie-redis-module).