---
date: "2013-09-27T20:12:02Z"
tags:
- csharp
- compilers
title: PrettyPrint C# codes via NRefactory
---

Well, yet another code example via NRefactory. This time we intend to take advantage of reformatting capabilities in the NRefactory library. What does it mean? Well, when you become engaged in code-generating activities, you usually don't want to be involved in details of code formatting, indentation, and these kinds of stuff. All you want to do is concatenate some codes, one behind another, and create your desired code. After you're done with your code, you may have a program in one line, with no indentation. This is where NRefactory steps in. It can take your code, and by considering tons of available options, automatically reformat your code. Easy peasy!

I have created a rudimentary example of this operation that you can download from [here](http://ge.tt/6JuQk2o/v/3). It's quite simple and straightforward.

PS: I've uploaded binary files [here](http://ge.tt/6JuQk2o/v/2). In case you already downloaded the previous sample, you don't need to download binary files again. Now all you have to do is to reference these binary files to be able to build the project.

Oops! I made an honest mistake and used Formatters. I've applied changes and updated the code. Formatters are appropriate tools when you want to apply modifications in IDE (like preserving correct indentation after copy-paste or when IDE fills some fields for you). In our case, the proper tool would be OutputVisitors. We create a parse tree of our code, then visit it by CSharpOutputVisitor and... Boom!