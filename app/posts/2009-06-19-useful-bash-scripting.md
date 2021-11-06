---
title: "Useful bash scripting"
date: "2009-06-19"
---

> Kevin Pierce showed me some handy scripting when I was updating some svn stuff.

```bash
for x in static/ yourapp/ index.yamltemplates/; do svn mv $x appengine_starter_kit/; done
```

Basically, this sets up a for loop that's iterating over some directories that I
wanted to move into a sub directory. I hadn't done much bash scripting, but this
is much more efficient than typing out the lines 1 at a time.

Useful!

