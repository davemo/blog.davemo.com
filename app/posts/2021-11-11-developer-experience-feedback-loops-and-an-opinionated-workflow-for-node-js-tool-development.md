---
title: "Developer Experience, Feedback Loops, and an Opinionated Workflow for Node.js Tool Development"
date: "2021-11-11"
---

> If you're experienced and prefer code to prose, here's the [workflow template](https://github.com/davemo/nodejs-tool-dev-template).

There's been a lot of focus on the topic of DX or developer experience recently, which is _great_ because it's something that I'm passionate about improving on the teams I work with. So passionate, in fact, that I recently transitioned out of a customer-focused engineering role into one focused on developers, tooling, and infrastructure. 🎉

Now you might be asking yourself, 'What does DX _actually_ mean?', and you would be justified in asking -- I've heard varied interpretations of the term. I particularly like this laser-focused definition from [Jean Yang](https://twitter.com/jeanqasaur) in her recent post [The Case for Developer Experience](https://future.a16z.com/the-case-for-developer-experience/)

> What I mean by **developer experience** is the sum total of **how** developers interface with their **tools**, end-to-end, day-in and day-out.

I think that a big part of the "how" that Jean mentions is the concept of _feedback loops_. Good developer tools provide affordances that reduce cognitive load, surface key information at the right time, and (most importantly) prioritize keeping feedback loops _fast_.

It should be no surprise, then, that companies investing in prioritizing developer experience are the ones growing.

Nothing depletes my [cognitive batteries](https://en.wikipedia.org/wiki/Ego_depletion) faster than slow, clunky tools. 😤

(While it would be fun to dive deeper into the topic of DX in general, I think I'll save that for another blog post -- but if you're as much of a software history nerd as I am, you may enjoy [The evolution of developer experience in the 20th century](https://www.linkedin.com/pulse/evolution-developer-experience-20th-century-stan-james/) by [Stan James](https://twitter.com/wanderingstan))

## You _can_ have a great developer experience writing command-line tools with Node

I first started working with [Node](https://nodejs.org) around [version 0.4](https://github.com/nodejs/node-v0.x-archive/blob/v0.4.0/ChangeLog) in 2011 and at the time I had absolutely no idea how anything worked. I was coming from a designer-first frontend background and my knowledge of JavaScript was limited to the execution context of the [web browser](https://www.youtube.com/watch?v=Lsg84NtJbmI).

Jumping into Node was extremely disorienting for me, up was down and left was right, `window` was `global` and there was no `XHR` or `DOM`. Writing modules, packages, and command-line tools was all new to me, yet I was intrigued by the possibility to leverage my knowledge of JS and expand into the world of tool building and systems programming.

Around this time I was working with [Justin Searls](https://twitter.com/searls) who created [LinemanJS](https://www.youtube.com/embed/KERJkJNV5nI) after conversations we had about frustrations I was experiencing with frontend tooling at the time. (If you haven't heard of Lineman, it's a command-line tool for building frontend apps that got reasonably popular in our consulting circle around 2013. It still works and it's what's [powering this blog](https://github.com/linemanjs/lineman-blog-template/)).

This experience was transformative for me because up until that point the tools I was using were clunky, written in other languages I didn't know as well, and incredibly slow. Justins' focus on the DX of Lineman was immediately apparent and the fact that it was written in JavaScript (ok, and a _lot_ of CoffeeScript) made it easy for me to contribute to. It was empowering to have someone was able to listen to my frustrations and translate them into magic on the command-line!

Since then, I've been able to work on some of my own tools, libraries, and plugins while picking up a few tips, tricks, and many opinions along the way. My hope is that sharing my experience will give you a **starting place** I wished I had when learning to build tools in Node.

## Ok, but how do _I_ start?

The rest of this post will take the form of a guided tutorial to help you get started building tools in Node with a fast feedback loop, and might give you some answers to these questions:

- How can I **iterate** on a node module locally without publishing to npm?
- How can I invoke my tool from **npm scripts**?
- How can I **debug** the code while developing?
- How can I write automated **tests** ?
- How should I **package** things?

(Keep in mind, **I'm biased!** If you're experienced and have done this before there's a good chance my approach will probably differ from yours and that's ok. There are many tools and techniques I'm not familiar with -- please let me know on [twitter](https://twitter.com/dmosher). I'm always eager to learn).

### Getting started

 You'll need the following pre-requisites in order to follow along:

- an installation of `node >= v16` and `npm >= v8`
- a terminal app like `terminal.app` or `powershell`
- your favorite code editor

First, create a folder where you can work. I will be using `~/code/node`. Then, run the following commands in your terminal to create some subdirectories and clone my [workflow template](https://github.com/davemo/nodejs-tool-dev-template).

```bash
# create tutorial directory
mkdir -p ~/code/node
cd ~/code/node

# create the my_project directory and initialize it with npm
mkdir my_project
cd my_project
npm init -y
cd ..

# create the my_tool directory and clone the workflow template
mkdir my_tool
cd my_tool
npx degit davemo/nodejs-tool-dev-template
npm i
```

Using the [`tree` command](https://formulae.brew.sh/formula/tree), here's what things should look like after running the above.

```shell
$ tree -L 2 ~/code/node

~/code/node
├── my_project
│   └── package.json
└── my_tool
    ├── dist
    ├── index.js
    ├── lib
    ├── node_modules
    ├── package-lock.json
    ├── package.json
    └── test

6 directories, 4 files
```

## Setting things up to develop with `npm link`

Often you will want to test a node module locally without having to publish to npm.

NPM allows us to do this with `npm link`, which will "connect" the two folders above using symbolic links which will allow us to iterate while developing our tool _and_ test our changes in a real project at the same time.

Package linking is a **two-step process**.

### Step 1: Link `my_tool` to the global node_modules folder

```shell
$ cd my_tool
$ npm link

added 1 package, and audited 3 packages in 634ms
```

This adds a symbolic link to the _global_ node_modules directory on your computer, which you can find using `npm prefix -g`. Here's what it looks like on my machine:

```shell
$ npm prefix -g
/Users/davidmosher/.nodenv/versions/16.13.0

$ ls -la $(npm prefix -g)/lib/node_modules
my_tool -> ../../../../../code/node/my_tool
```

### Step 2: Link-install `my_tool` tool into the `my_project` directory

Next, we'll use `npm link my_tool` from _within_ `my_project` to complete the linking process.

```shell
$ cd my_project
$ npm link my_tool

added 1 package, and audited 3 packages in 516ms

$ ls -la node_modules/
my_tool -> ../../my_tool
```

Once we've completed those two steps then we're ready to start iterating on `my_tool` inside of `my_project`.

## Invoking our tool using npm scripts

The workflow template we cloned into the `my_tool` directory earlier comes with an entrypoint file which will be our CLI tool. That entrypoint requires a module that logs a simple message to `STDOUT` and completes after a delay of 1 second.

```shell
$ cd my_tool
$ tree -L 2
.
├── index.js    # entrypoint file
└── lib
    └── tool.js # module that logs to STDOUT
```

```javascript
// lib/tool.js
module.exports = function tool() {
  console.log('⏳ CLI tool: working ...')
  setTimeout(function() {
    console.log('✅ CLI tool: done!')
  }, 1000);
}
```

Now that we've got things linked up, we can make a quick test to see if our module is working using npm scripts inside `my_project/package.json`:

Let's connect that tool

> If you're new to systems programming altogether you might enjoy this [gist I created](https://gist.github.com/davemo/3c6042086deff4c2fd8a5f16751050d4) with some learning resources on the topic. Jumping into building tools with Node assumes at least _some_ of this knowledge.


To get started

> ncc with build and watch flag
> a command-line tool with a binary
> boilerplate repo cloneable with npx degit
> tests setup with teenytest and testdouble.js