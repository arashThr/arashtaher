+++
title = "Chunk size is part of the pointer"
date = "2026-10-12T09:00:00Z"
draft = true
tags = ["ai", "embeddings", "retrieval"]
[params]
  kind = "til"
+++

An embedding points at the text you actually sent to the model. If I split a document into chunks first, the vector points at the chunk, not at the document. The chunk boundary is part of the pointer.

Cut on a fixed 200 tokens and a function ends up in one chunk while its comment and its tests land in the next. Search then returns a slice that cannot answer the question, even when the cosine distance looks great. Cut on a heading or a function and the pointer aims at something a person could quote.

I store the chunk text next to the vector, plus the source path and the offsets. Without the offsets I cannot show the hit, and I cannot tell two chunks from the same file apart. The model name still has to travel with the vector. The chunking rule does too. Change either one and the old neighbors are a different index.
