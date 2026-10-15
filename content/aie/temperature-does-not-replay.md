+++
title = "Temperature does not replay"
date = "2026-10-15T00:15:00Z"
draft = true
tags = ["ai", "evals"]
[params]
  kind = "til"
+++

Temperature changes how the next token is picked. At zero the model takes the most likely token each time. Above zero it samples, so two calls with the same prompt can differ. That is the whole knob.

I wanted it to behave like a seed in a test: set a number, store it next to the request, and replay the run. It does not work that way. Temperature is not a random seed. Unless the API also gives me a seed and promises to honor it, I cannot reconstruct the draw. A failing eval that "passed yesterday" is often this, not a regression in my code.

For anything I want to assert exactly, I keep temperature at zero and I still treat the output as text, not as a snapshot I can byte-compare forever. Models change. For anything I want to judge, I write down what would still be true if the wording moved.
