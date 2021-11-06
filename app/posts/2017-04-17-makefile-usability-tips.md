It has been but a [few short years](/build-automation-holy-war.png) since _web developers_ chose a side and took up arms in the holy war of <a href="https://en.wikipedia.org/wiki/Make_(software)">build automation tools</a>; this is only one of [many](https://en.wikipedia.org/wiki/Editor_war) [wars](https://en.wikipedia.org/wiki/Browser_wars) that have been fought [countless times](https://en.wikipedia.org/wiki/Indent_style) since the dawn of computing. In the grim darkness of the far future, there is only war.

...

Meh. War is tiresome and I have had enough of war. This post is about some small usability improvements you can add to your Makefiles if you are using Make. Let's dig in!

# The Makefile

Make has been around for a <a href="https://en.wikipedia.org/wiki/Make_(software)">long time</a>. It has some neat features but it's not always the friendliest to neophytes. Imagine you have a new developer joining your team, and your project has a Makefile that looks something like this:

```Makefile
VERSION ?= $(shell cat VERSION)

.PHONY: version clean bump release

build:
  @echo "building..."
  # build the app here

clean:
  # rm -rf build

release:
  # bump
  # make push -e VERSION=$(shell cat VERSION)

push:
  # push the build artifact at a given version somewhere

version:
  # cat VERSION

bump:
  # using semver, bump the version by a major, minor or patch increment
```

At first glance this Makefile isn't all that complicated but chances are your build automation process is composed of many more lines of code or even split into multiple places. The wise aged veteran developer on your team tells the new member "to build this project just clone this repo and run `make`" after which the new developer sees:

```shell
neophyte@newbie:~/code/project
$ make
building...
```

Now, assuming new dev didn't encounter any snags with project setup and installing dependencies (hah! unlikely) this still doesn't present a great picture of how the project is assembled or the bits of the lifecycle that are involved at first glance. Let's see if we can improve this initial Makefile developer experience.

## Step 1: Add a DEFAULT_GOAL

In Make semantics, _goals_ are targets that `make` should strive to update. The docs give us a nice [explanation of goals](https://www.gnu.org/software/make/manual/html_node/Goals.html) as well as some hints about how we can manage which goal is run first:

> By default, the goal is the first target in the makefile (not counting targets that start with a period). Therefore, makefiles are usually written so that the first target is for compiling the entire program or programs they describe. If the first rule in the makefile has several targets, only the first target in the rule becomes the default goal, not the whole list. You can manage the selection of the default goal from within your makefile using the .DEFAULT_GOAL variable (see [Other Special Variables](https://www.gnu.org/software/make/manual/html_node/Special-Variables.html#Special-Variables)).

Even though the docs give us some informal conventions about the first target in our Makefile I think it _makes_ (heh) for a better experience if we add some sort of help target that spits out some information to the terminal. Make doesn't have any facility to display help messages like some [other build automation tools](http://rake.rubyforge.org/Rake/Application.html), but it won't be too hard to add one. First, let's add a default goal of help:

```Makefile
.DEFAULT_GOAL := help

help:
  @echo "Welcome to the Project!"
```
<caption>
  <strong>Tip:</strong> prefixing a line in your make target with `@` suppresses output of that line to stdout.
</caption>

<br />With this in place our new developer sees the following:

```shell
neophyte@newbie:~/code/project
$ make
Welcome to the Project!
```

Ok, this is a little more friendly but still not very useful. We can do better!

## Step 2: Annotate Makefile Targets

Let's update our Makefile to add helpful annotations to _some_ of our targets using comment blocks prefixed with `##`:

```Makefile
build: ## builds the application
  @echo "building..."

clean: ## gets you back to a clean working state
  # rm -rf build

release: bump ## bump the VERSION file, git tags, and push to github
  # make push -e VERSION=$(shell cat VERSION)
```

This annotation scheme works pretty well but doesn't buy us anything on its own, to make this truly useful we need to parse the Makefile, look for lines prefixed with `##` and format them in a pretty way and write them to `stdout`

## Step 3: Parse Annotations

Make includes a handy [list of special variables](https://www.gnu.org/software/make/manual/html_node/Special-Variables.html#Special-Variables) that can be used for all sorts of handy things. In this case we can use the `MAKEFILE_LIST` variable along with `grep`, `sort` and `awk` to get a list of annotated targets and display them on `stdout` in a user-friendly way:

```Makefile
help:
  @grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | sort | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-30s\033[0m %s\n", $$1, $$2}'
```
<caption>
  <strong>Tip: </strong>Wondering what the `help` target is doing? See this [explain shell](https://explainshell.com/explain?cmd=grep+-E+%27%5E%5Ba-zA-Z_-%5D%2B%3A.*%3F%23%23+.*%24%24%27+%24%28MAKEFILE_LIST%29+%7C+sort+%7C+awk+%27BEGIN+%7BFS+%3D+%22%3A.*%3F%23%23+%22%7D%3B+%7Bprintf+%22%5C033%5B36m%25-30s%5C033%5B0m+%25s%5Cn%22%2C+%24%241%2C+%24%242%7D%27).
</caption>

<br />With that in place our new developer would run `make` from the command-line and see:

```shell
neophyte@newbie:~/code/project
$ make
build                          builds the application
clean                          gets you back to a clean working state
release                        bump the VERSION file, git tags, and push to github
```

Yay! This is a much nicer developer-experience than what we started with. To take it even further I might suggest annotating only a subset of tasks that are most commonly used.

# Acknowledgements / Links

There are a few sources that come up when you google for "self-documenting makefile" along with a few different ways of solving this problem. I drew inspiration for this post mostly from [this marmelab entry](https://marmelab.com/blog/2016/02/29/auto-documented-makefile.html), but felt like there were enough interesting points and general make tips added that it was worth another post.

Other links you may find useful:

- [Full Makefile as Gist](https://gist.github.com/davemo/c0462e8196289e0fb0210ee63ff02962)
- [VERSION bump script as Gist](https://gist.github.com/davemo/88de90577a57698dd72d722bcfc44964)
- [GNU Make](https://www.gnu.org/software/make/)
- [Self Documenting Makefiles](https://www.cmcrossroads.com/print/article/self-documenting-makefiles)
- [Explain Shell](https://explainshell.com)