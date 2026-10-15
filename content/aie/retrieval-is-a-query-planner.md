+++
title = "Retrieval is a query planner"
date = "2026-10-14T18:00:00Z"
draft = true
summary = "Search over embeddings is a query planner that returns neighbors. The index is only as stable as the model name and the chunking rule stored beside each vector."
tags = ["ai", "embeddings", "retrieval"]
builds_on = ["what-an-embedding-is", "chunk-size-is-part-of-the-pointer"]
[params]
  kind = "essay"
+++

I keep reaching for the database words, and this time they fit. A retrieval system is a query planner. The query is a vector. The index returns neighbors. Something after that decides which neighbors are worth putting in front of the model. None of that step is generation. Generation is what you do with the rows.

The embedding note is the reason I trust the split. A vector is a pointer, not a paragraph. Cosine distance does not understand the question. It only knows which stored pointers sit near the pointer I just made. If I blur that into "the model searched," I start debugging the wrong layer when the answer is wrong. The search can be fine and the prose can still be bad. The prose can be fluent and the search can have returned the wrong file.

The chunk note is the other half of the same bug. The pointer aims at whatever text I embedded. A fixed-size cut through a Go file produces neighbors that look close and quote nothing you can use. A cut on a function, with the path and the offsets stored beside the slice, produces a hit I can open. I would not ship a table without a primary key. I should not ship a vector without the coordinates of the text it points at.

Schema version lives in the same row. The dimension count belongs to the model. Swap models and the old slices are not in the same space, even when the column type is still `[]float32`. The chunking rule is a second version. Rebuild the chunks and the ids no longer mean what they meant. I want both names in the table, the way I want a migration version in a schema, so a later reader can tell a rotten index from a rotten prompt.

The planner metaphor also tells me what not to put in the prompt. The context window is finite, and the neighbors are the rows I chose to project. Returning twenty chunks because the index had twenty hits is the same move as `SELECT *` on a wide table and then hoping the caller sorts it out. I would rather return a few, with the path attached, and spend the rest of the budget on the question.

I am not ready to call this a stack. I am ready to call it a shape I can test. Given a fixed model and a fixed chunking rule, the same query should return the same neighbors. When it does not, the index moved, and no amount of clever prompting will put the right file back.
