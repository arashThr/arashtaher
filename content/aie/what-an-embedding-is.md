+++
title = "What an embedding is"
date = "2026-10-14T09:00:00Z"
draft = true
tags = ["ai", "embeddings"]
[params]
  kind = "til"
+++

An embedding is a list of numbers that stands in for a piece of text. A model reads the text and writes down a point in a high-dimensional space. Two notes land near each other when the model thinks they mean similar things, even if they share no words.

Coming from Go, the useful picture is a `[]float32`, not a class hierarchy. You store the slice next to the document id. Search is "who else is close to this slice," usually by cosine distance. Nothing in that step understands English. The understanding happened earlier, when the model built the vector.

That split is the whole idea. Generation is the model talking. An embedding is the model pointing. I can index pointers in Postgres or a plain file long before I trust a chatbot with a user's question.

The number of dimensions is a property of the model, not of my schema. Change models, and the slices are no longer comparable. I keep the model name beside the vector for that reason.
