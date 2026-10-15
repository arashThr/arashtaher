+++
title = "What a token is"
date = "2026-10-11T09:00:00Z"
draft = true
tags = ["ai", "tokens"]
[params]
  kind = "til"
+++

A token is the unit the model counts. It is not a word, and it is not a character. The tokenizer splits text with a vocabulary that was frozen when the model was trained. "embedding" might be one token. A camel-cased identifier from a Go repo might be three. Whitespace and punctuation get their own pieces.

I kept treating the context window as a word limit. It is a token budget, and the bill for an API call is usually the same unit. A prompt that looks short can be expensive once it is full of code, and a prompt that looks long can be cheap if it is ordinary prose.

The useful habit is to count before I argue about length. Most providers will tokenize a string for you. Until I do that, "this prompt is too big" is a guess. The guess is often wrong in the direction that blows the budget on the call I cared about.
