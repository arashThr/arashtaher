+++
title = "Python REPL cheatsheet"
date = "2026-10-14T09:00:00Z"
draft = true
tags = ["tools", "python"]
[params]
  kind = "til"
+++

Series of commands and configuration that can help with using Python interactive shell better:

* **`F1` / `F2` / `F3`:** View docs pager (`F1`), search history (`F2`), and paste multi-line blocks cleanly (`F3`).
* **Exit easily:** Type `exit` or `quit` (no parentheses needed) or hit `Ctrl + D`.
* **Last output (`_`):** Use `_` to reuse the result of your previous line.
* **Inspect quickly:** Press `Tab` twice for autocompletion, or use `help(obj)` and `dir(obj)`.
* **Inspect scripts (`python3 -i file.py`):** Runs a script and drops you into the shell with all its variables kept in memory.
* **Auto-load imports (`PYTHONSTARTUP`):** Set a `~/.pythonstartup` file in your `.zshrc` to automatically import favorite modules on launch.
