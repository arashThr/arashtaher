---
date: "2014-03-11T19:12:48Z"
tags:
- c
- languages
- syntax tree
title: Binary Operator Expressions
---

Suppose in a hypothetical scenario you want to reverse all binary operations in your file, and also you want them to be fully parenthesized. What would you do? One solution is using recursion, which might be a little messy and unclear. Another solution to this problem can be achieved by taking advantage of binary operator expressions in NRefactory. Fortunately, with NRefactory, this operation is rather a trivial task. A little tricky, but still simple. You can use this feature to process any kind of binary operation and interpret it the way you like (like generating code).

First, let's create a test fixture for it (Hooray! Now you know what TDD is :))

```csharp
[Test]
public void BinaryVisitorTest() {
    string input = "a > b || (x > y && y > z)";
    var parser = new CSharpParser();
    Expression expression = parser.ParseExpression(input);
    var visitor = new BinaryOpVisitor();
    expression.AcceptVisitor(visitor);
}
```

Since we're interested in visiting an expression, we don't bother by parsing a whole C# file. We give the parser our expression as text, and it gives us the expression as AST. In the next step, we create a visitor class and visit binary and identifier expressions:

```csharp
public class BinaryOpVisitor : DepthFirstAstVisitor {
    public override void VisitBinaryOperatorExpression(BinaryOperatorExpression binaryOperatorExpression) {
        Console.Write("(");
        binaryOperatorExpression.Right.AcceptVisitor(this);
        Console.Write(binaryOperatorExpression.OperatorToken);
        binaryOperatorExpression.Left.AcceptVisitor(this);
        Console.Write(")");
    }

    public override void VisitIdentifierExpression(IdentifierExpression identifierExpression) {
        Console.Write(identifierExpression.Identifier);
        base.VisitIdentifierExpression(identifierExpression);
    }
}
```

Be careful, as opposed to what we do regularly in node visiting (or actually what **depth first** visiting is all about), we didn't call the base visitor in the binary operator expression visitor. Now, for this special case, the output will be:

```
(((z>y)&&(y>x))||(b>a))
```

Easy peasy! For readers with a data structure background, I'd like to mention that what we did here was actually an in-order visit of the nodes in AST. You can simply turn it into post/pre-order by putting the base class call before/after your code in the visitor.