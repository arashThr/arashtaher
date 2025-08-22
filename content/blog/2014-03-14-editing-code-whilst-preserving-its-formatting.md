---
date: "2014-03-14T11:04:43Z"
tags:
- csharp
- compilers
title: Editing Code whilst preserving its formatting
---

Earlier in one of my [posts](/prettyprint-c%23-codes-via-nrefactory/ "PrettyPrint C# codes via NRefactory"), I explained how you can reformat your code using the NRefactory library. But, as a matter of fact, what you really want in your day-to-day task is not reformatting code; au contraire, you want its formatting to be preserved. You don't want to commit dozens of files to your repository merely because their formatting's changed!

Now this question arises: is this quest possible in NRefactory or not? Well, of course it is, and it's really easy. (Once you know what you have to do, who you have to call, and...)

BTW, NRefactory is an essential part of the SharpDevelop IDE, and we don't want our idea to reformat our code every time we use IntelliSense. NRefactory has a class that's dedicated to doing such, and it's called DocumentScript. Document scripts work by manipulating IDocument objects, which are a specialization of the string builder class. This class gives you the opportunity to change your document based on text locations that were already stored in the syntax tree. It also keeps track of the latest modifications and maps them to the current document, so you don't have to worry about whether multiple changes on the same document will be applied correctly or not.

```csharp
IDocument document = new StringBuilderDocument("Your code source");
CSharpFormattingOptions policy = FormattingOptionsFactory.CreateAllman();
var options = new TextEditorOptions();
var script = new DocumentScript(document, policy, options);
```

Now you can use methods like Replace, Remove, InsertAfter, etc., on your AST. It works with both AST nodes as well as offsets. Besides that, there are some predefined methods on

```csharp
script.ChangeModifier(declaration, Modifiers.Public);
```

![script](/wp-content/uploads/2014/03/script.png)