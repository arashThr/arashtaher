+++
title = "A context window is a budget"
date = "2026-10-13T09:00:00Z"
draft = true
tags = ["ai", "tokens"]
[params]
  kind = "til"
+++

The context window is how many tokens the model will read on one call. It is a budget, shared by the system prompt, the retrieved chunks, the conversation, and the answer I still want back. Fill it and the call fails, or the model quietly spends the budget on the middle of the prompt and ignores the ends.

A bigger window is not the same as the model having read the repo. It only means this call can hold more. I still decide what is in it. Stuffing every file "just in case" makes the budget worse: the relevant function is in there, and so is a lot of noise the model will treat as equally present.

I want the same instinct I have with a query plan. Know which part is expensive, put the small precise thing where it will be seen, and leave a reserve for the output. The number on the model card is the limit. It is not a strategy.
