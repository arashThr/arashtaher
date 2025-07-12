---
date: "2012-08-08T01:53:07Z"
tags:
- bash
- linux
title: BashTertainment
---

There's nothing out there that can be considered as a worthy replacement for bash. The power it gives you is so enormous that it takes years for someone to become truly proficient. I'm not an expert in the terminal at all, but I still enjoy it on some levels. These are some of the command combinations that I found much more interesting during the past days, worth giving a glance:

### How to select and sort mp3 music files (or any other regular expression you desire) in a messy directory and pipe them into the Totem player:

```bash
find -iname '*.mp3' | sort -n | xargs -d '\n' totem &
```

### How to search in a specific column of a file (like the output of objdump -t) and select qualified lines:

```bash
awk '{if ($4==".data" || ($3=="F" && $4==".text") ) {print $0} }' [filename]
```

### How to find and copy large files from the browser cache:

This one can be very helpful. You have visited a web page and saw some videos on it. Now you want to watch them again. Go to `.mozilla` or `.cache` (for Chromium) directory and then enter:

```bash
find -size +5M -exec cp {} ~/Videos ;
```

(For more options, like creation date filters, visit the `find` man page)

### How to pipe the output of a command into vim:

```bash
... | vim -
```

### Create a bootable flash disk from an ISO installation file:

Notice: use `sudo fdisk -l` to make sure you copy your ISO file into the correct destination.

```bash
sudo dd if=~/Desktop/ubuntu12.04.iso of=[/dev/sdb] oflag=direct bs=1048576
```

Alright! That's enough for today. Maybe we'll continue this later :)