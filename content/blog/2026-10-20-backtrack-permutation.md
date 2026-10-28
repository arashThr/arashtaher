---
title: Backtrack permutation
date: 2026-10-20T12:55:26.076Z
tags:
  - algorithm
  - dsa
  - python
  - math
---

Here are two of my favorite algorithm problems solved with backtracking: Finding permutations and all subsets.

```python
def perm(input: list[str]):
    results: list[str] = []
    l = len(input)

    def backtrack(pos: int):
        if pos == l:
            results.append("".join(input))
        else:
            for i in range(pos, l):
                input[i], input[pos] = input[pos], input[i]
                backtrack(pos + 1)
                input[i], input[pos] = input[pos], input[i]

    backtrack(0)
    print(results)


def subsets(input: list[int]):
    results: list[list[int]] = []

    def backtrack(input: list[int], pos: int, end: int):
        if pos == end:
            results.append(input)
        else:
            backtrack(input[:], pos + 1, end)
            backtrack(input[0:pos] + input[pos + 1 :], pos, end - 1)

    backtrack(input, 0, len(input))
    print(results)
```
