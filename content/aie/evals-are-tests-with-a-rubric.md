+++
title = "Evals are tests with a rubric"
date = "2026-10-15T00:30:00Z"
draft = true
summary = "An eval is a test whose oracle is a rubric. Exact string matches flake the moment sampling or a model swap changes the wording, so the assertion has to name what would still be true."
tags = ["ai", "evals", "tokens"]
builds_on = ["temperature-does-not-replay", "a-context-window-is-a-budget"]
[params]
  kind = "essay"
+++

In Go I know when a test is a test. I arrange a value, call a function, and `reflect.DeepEqual` tells me if I lied. The oracle is the value. AI work keeps the shape and changes the oracle. The function returns prose. Prose that means the right thing can be spelled a dozen ways. An assertion on the exact string fails when nothing important changed.

That is what I mean by a rubric. The test still has a fixture and a call. The pass condition is a list of claims I am willing to check: the answer names this function, it does not invent a flag that does not exist, it refuses when the retrieved chunks are empty. Some of those claims are code I can write. Some of them are another model call with a smaller prompt whose only job is to vote yes or no. Both are tests. Neither is a vibe.

Temperature is why the exact match was never going to last. Above zero, the same prompt is allowed to come back different. Even at zero I do not want the wording to be the contract, because the model on the other side of the API will move and the contract should not. The note I want next to a flaky eval is not "rerun it." It is "this assertion was pinned to a draw."

The context window decides whether the fixture is honest. If the rubric says the model must cite a file, that file has to be in the budget, and the budget has to have room left for the answer. A test that passes only when I paste the whole repository is testing the window, not the behavior. I have written that test by accident. It goes green on a large model and red on a small one, and I learn nothing about either except which one can hold more tokens.

I want the suite small enough to run on a change, the way I want `go test` on the package I touched. A hundred hand-labeled questions I can read is more useful than a thousand I will never open. When one fails I should be able to see the prompt, the chunks, and the rubric side by side. If I cannot, the eval is a score, and a score is not a test.

The habit I am trying to keep is the one from code review. A failure sits next to the case that produced it. I do not edit the rubric until the case is green and then forget what the rubric used to demand. The old claim stays, marked as wrong, the way a bad assertion stays in the history of the test file.
