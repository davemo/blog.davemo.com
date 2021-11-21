---
title: "Using the SED stream editor in macOS terminal.app"
date: "2009-10-27"
---

This is pretty useful, piping the results of the echo to the "sed" command which
stands for "stream editor" and then iterating over things in a loop and batch
renaming them. I could have renamed them manually, but this was more fun and I
learned something!

```bash
for x in *\ *; do y=$(echo "$x" | sed y/\ \/./); mv "$x" "$y"; done
```