# Creating content

`make` creates a draft from one of these archetypes. The first argument is the URL slug: lowercase words separated by hyphens. Add `title="..."` when the title is not just the slug with spaces.

```bash
make post my-post title="My Post"
make til my-note
make essay my-essay
make section garden title="Garden"
```

Remove `draft = true` when the page should publish. Until then it only shows up under `hugo server -D`.

## Blog post

`make post` writes `content/blog/YYYY-MM-DD-<name>.md`. The date in the filename matches the older posts. The URL does not use it.

| Field | What it does |
| --- | --- |
| `title` | The heading. Safe to edit later. |
| `slug` | The URL: `/blog/<slug>/`. Set from the argument you passed, so fixing the title does not change the address. |
| `date` | Filled in when the file is created. |
| `draft` | Unpublished while true. |
| `tags` | Topic labels. See below. |

## TIL

`make til` writes `content/aie/<name>.md`. The URL is `/aie/<name>/`, taken from the filename. Renaming the file changes the URL. Editing the title does not.

A TIL is one short note. The `/aie/` list shows the whole note inline.

`tils` and `essays` are reserved filenames. Those paths are the filter pages.

## Essay

`make essay` writes `content/aie/<name>.md`. Same filename URL as a TIL.

The `/aie/` list shows the Essay label, the date, the reading time, and `summary`. The essay also appears on the blog list and in the blog and home feeds. A TIL does not.

| Field | What it does |
| --- | --- |
| `summary` | The sentence on the list and in the feeds. |
| `builds_on` | TILs this essay is made from. Each entry is a filename in `content/aie/` without `.md`, for example `builds_on = ["what-an-embedding-is"]`. The essay links to those notes. Each note links back to the essay. A name that does not exist is shown as plain text. |
| `tags` | Topic labels. |

`kind` is under `[params]` in both TILs and essays. Hugo reserves a top-level `kind` and warns about it. Leave the table where the archetype put it. There is no `layout` field. The template reads `params.kind`.

## Section

`make section` writes `content/<name>/_index.md`, a draft, with a menu link at `weight = 10` (after CV, before Tags at 20 and Contact at 30). Change `weight` to move it. The text under the front matter is the intro on `/<name>/`.

Pages in that folder use the ordinary page layout:

```bash
hugo new content garden/my-note.md
```

TILs and essays stay in `content/aie/`. That series has its own list, filters, and feeds. A new section does not copy them. A page created straight into `content/aie/` without `make til` or `make essay` has no `params.kind`. `hugo server -D` rejects it, and so does a production build once `draft` is removed.

## Tags

`tags` is a list of short labels. Any new label is fine. Reusing one files the page onto that tag's page, for example `/tags/ai/`.

Labels already used on the series: `ai`, `embeddings`, `evals`, `learning`, `retrieval`, `tokens`. Blog posts use whatever fits the post (`go`, `llm`, and so on). Tags are shared across the blog and the series, and related posts are other pages with a tag in common.
