---
date: "2013-11-07T13:08:48Z"
tags:
- algorithm
- python
- recursion
title: 'Recursive problems: Set partitioning'
---

There's no doubt that recursion is one of the most powerful, exciting, and yet difficult approaches for problem-solving. As we all know, attacking a problem with this almighty tool requires a keen mind and craftsmanship in extracting a recursive structure; a subtle perspective that can only be acquired by constant practice. (Reminds me of Pride and Prejudice, have you read it?)

One of the problems that I faced recently was finding all the partitions of a set. A [set partition](http://mathworld.wolfram.com/SetPartition.html) of a set S is a collection of disjoint subsets of S whose union is S. An interesting fact is that after a few struggles in set domain problems, it becomes straightforward to find a way to deal with another one of them. It's mainly in a "One time choose it, one time don't" fashion.

BTW, this is my solution for this problem in Python.

```python
# Prints partitions of set: [1,2] -> [[1],[2]], [[1,2]]
def part(lst, current=[], final=[]):
    if len(lst) == 0:
        if len(current) == 0:
            print(final)
        elif len(current) > 1:
            print([current] + final)
    else:
        part(lst[1:], current + [lst[0]], final[:])
        part(lst[1:], current[:], final + [[lst[0]]])
```