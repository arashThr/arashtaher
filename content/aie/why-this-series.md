+++
title = "Why I'm writing this series"
date = "2026-10-15T00:00:00Z"
draft = true
summary = "I'm writing down the path from Go services to AI engineering as short notes, then stitching the ones that hold up into essays."
tags = ["ai", "learning"]
builds_on = ["what-an-embedding-is"]
[params]
  kind = "essay"
+++

I have spent years writing Go services. The work has a shape I trust: a request comes in, the code does a small thing, a test tells me if I lied. AI engineering does not start that way. The first weeks are a pile of names — tokens, context windows, embeddings, evals — and each name hides a different kind of object.

I am not switching careers in a weekend, and I do not want a second blog that restates whatever the model vendors shipped this morning. I want a trail I can walk back. The short notes are the trail. Each one is a single idea I had to get straight before the next idea would sit still. They are allowed to be obvious later. They are not allowed to smuggle in three topics so that I can feel productive.

Essays are the other half. A note records the moment something clicked. An essay is what I can still defend after a few more notes have corrected it. The embedding note is a good example. The whole claim is that a vector is a pointer, not a paragraph, and that the model name has to travel with the slice or the index quietly rots. That is small enough to check. It is also the reason I am suspicious of any demo that "just stores the text" and then acts surprised when search gets worse after a model swap.

The same habit is how I want to learn the rest of the stack. Tool calls are another shape of API, with a schema instead of a handler signature. Evals are tests whose oracle is a rubric, not `reflect.DeepEqual`. Retrieval is a query planner that returns neighbors instead of rows. None of those sentences are the work. They are the hooks I hang the work on, so that a Tuesday note about cosine distance and a Friday note about chunk size can meet in one place without me pretending I understood both on the day I met them.

Publishing them in one stream is deliberate. A separate TIL site would let the notes drift away from the essays, and the essays would turn into advice with the evidence edited out. Keeping both under this series means an essay can point at the notes it actually used, and a note can point back at the essay that grew out of it. Readers who want the long version can start there. Readers who want the one idea can stay on the list and read it in place.

I will get things wrong in the notes. That is the point of writing them before the essay. The correction belongs in public too, next to the original, not as a silent edit three weeks later. Go taught me to keep the failure next to the fix. I am trying to do that with the learning itself.

The series stays useful only if the short notes remain easy to find from the essay that grew out of them.
