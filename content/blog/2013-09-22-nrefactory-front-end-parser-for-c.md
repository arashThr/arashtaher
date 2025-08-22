---
date: "2013-09-22T06:20:16Z"
tags:
- csharp
- parser
- compilers
title: 'NRefactory: Front-end parser for C#'
---

[NRefactory](https://github.com/icsharpcode/NRefactory) is an open source library for parsing C# source codes, or more precisely a front-end parser for C#. It can parse your C# codes and provide you with an abstract syntax tree. It can also resolve this parse tree and give you semantic of nodes in the syntax tree. What makes it more interesting is that the syntax tree produced by this framework is mutable, which means you can change its node's contents; unlike other products, such as not-yet-stable [Microsoft® “Roslyn” CTP](http://msdn.microsoft.com/en-us/vstudio/roslyn.aspx).

You can use this library to change your source code, analyze it, or reformat it (pretty print). The NRefactory project is actually a part of a bigger project, [SharpDevelop](http://www.icsharpcode.net/opensource/sd/): A free IDE for C#. SharpDevelop takes advantage of this library for IntelliSense implementation and some other stuff.

At the beginning, it may take a while till you become comfortable with representations, APIs, and how to interpret and manipulate data structures. To start, take a look at [this article](http://www.codeproject.com/Articles/408663/Using-NRefactory-for-analyzing-Csharp-code), written by one of the authors of NRefactory. In this prologue, you can find all preliminary information you need to know in order to dive in. After that, IMHO the best practice is to explore the huge unit tests that exist in the project itself. They'll be your best guide through all difficulties and misunderstandings (there are about 3000 of them!).

I also wrote the simplest possible program with this library that you can download from [here](http://ge.tt/6JuQk2o/v/1?c "NRefactory sample code"). The purpose of this program is only to show you how to glue all the things together and make it work. Enjoy Parsing.