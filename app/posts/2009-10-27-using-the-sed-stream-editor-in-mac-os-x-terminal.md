---
title: "Using the SED stream editor in macOS terminal.app"
date: "2009-10-27"
description: "How to use the unix SED command to batch rename files."
---

<aside class="tldr">
Learning to use Unix CLI tools is enlightening.
</aside>

This is pretty useful, piping the results of the echo to the "sed" command which stands for "stream editor" and then iterating over things in a loop and batch renaming them. I could have renamed them manually, but this was more fun and I learned something!

```bash
for x in *\ *; do y=$(echo "$x" | sed y/\ \/./); mv "$x" "$y"; done
```