---
date: "2013-08-10T09:59:10Z"
tags:
- bugs
- open source
title: Practitioner
---

Yesterday, I was finally honored to contribute to an open source project, NRefactory: Front-end parser for C#. Although, I have to admit I was only a helper through this journey; in fact, at first, I was totally reluctant to dive into thousands of lines of code. After all, it’s still a bit scary! 🙂

Anyway, we did it, we found the problem and added our short piece of modification into the code. But what was the dilemma? The problem was an ambiguity in resolution when we had an object with the same name as the class name. In order to disambiguate it, the parser looks to see whether the method has a static modifier or not. Now, when we try to call an extension method from an object… Poof! The parser thinks this object is the class and… Well, all we had to do was to add another condition to check whether it’s an extension method or not.

I was so thrilled and I impatiently wanted to recompile our program to see the results. But wait! “Let’s not rush into it,” said the other guy. “First let’s see what are its side effects.” We checked every occurrence of this method in the code to make sure this change doesn’t cause any malfunction. After that, we ran the program and… it was working like a charm.

PS: Soon I’m gonna post a share about the [NRefactory](http://arashthr.wordpress.com/2013/08/10/332/ "NRefactory on GitHub") library and how I’m using it in developing an aggressive obfuscator for C#. So be prepared!