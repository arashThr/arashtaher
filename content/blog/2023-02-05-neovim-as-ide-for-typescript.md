---
date: "2023-02-05T15:40:44Z"
tags:
- JavaScript
- TypeScript
- VIM
title: NeoVim as IDE for TypeScript
---

NeoVim as IDE for Typescript

Here’s the list of some plugins you can use in NeoVim to make it a full-fledge IDE for developing Typescript projects:

[![](/wp-content/uploads/2023/02/screenshot-from-2023-02-05-16-32-17.png?w=1024)](/wp-content/uploads/2023/02/screenshot-from-2023-02-05-16-32-17.png)

```
wbthomason/packer.nvim
```

First and foremost, you need to have a proper package manager for NeoVim, so you can easily add, remove and update the plugins. The recommended plugin manager as of now for NeoVim is Packer.

```
junegunn/fzf
junegunn/fzf.vim
```

FZF helps you to easily navigate between files and find them with fuzzy search.

```
neovim/nvim-lspconfig
```

It’s a “collection of configurations for the built-in LSP client”. LSP enables features like auto-complete, go to definition and many more.

```
airblade/vim-gitgutter
```

For better integration between the editor environment and Git, I use two plugins. First one is GitGutter. This plugin “shows git diff markers in the sign column and stages/previews/undoes hunks and partial hunks”. If you learn the short keys, you can easily and quickly move between changes and undo or stage each hunk.

```
tpope/vim-fugitive
```

The second plugin that I use for Git, is Vim Fugitive. It’s a wrapper for Git commands and provides nice integration between Git and the editor. With this plugin installed, you have access to Git commands inside the editor. I usually use this for the diffs, staging files and committing the changes.

```
tpope/vim-commentary
```

Comments stuff out without much of a hassle. All you need to learn is `gc` and `gcc`

```
preservim/nerdtree
```

This is a must-have plugin for me. During the development, I like to have an overview of the files and quick visual access to where this file that I’m editing resides and what other files are in the same directory.

One of the very few mappings that I have added to my configurations are for NERDTree to find and show me the current file in the sidebar:

```
map <Leader>e :NERDTreeFind<CR>
```

In case you're interested to try these settings, go to my *[dotfiles](http://github.com/arashThr/dotfiles)* repository on GitHub.