---
title: "Developer Experience, Feedback Loops, and an Enjoyable Workflow for Node.js Tool Development"
date: "2021-11-11"
theme: "tldr"
---

<aside class="tldr">
If you're experienced and prefer code to prose, you can explore the <a href="https://github.com/davemo/nodejs-tool-dev-template">code on github</a> or <code>npx degit davemo/nodejs-tool-dev-template</code>.
</aside>

There's been a lot of focus on the topic of DX or developer experience recently, which is _great_ because it's something that I'm passionate about improving on the teams I work with. So passionate, in fact, that I recently transitioned out of a customer-focused engineering role into one focused on developers, tooling, and infrastructure.

Now you might be asking yourself, 'What does DX _actually_ mean?', and you would be justified in asking -- I've heard varied interpretations of the term.

[Jean Yang](https://twitter.com/jeanqasaur) defines it this way in [The Case for Developer Experience](https://future.a16z.com/the-case-for-developer-experience/):

> What I mean by **developer experience** is the sum total of **how** developers interface with their **tools**, end-to-end, day-in and day-out.

I think that a big part of the "how" there is the concept of _feedback loops_. Good developer tools provide affordances that reduce cognitive load, surface key information at the right time, but most importantly, good tools prioritize keeping feedback loops _fast_.

Nothing depletes my [cognitive batteries](https://en.wikipedia.org/wiki/Ego_depletion) faster than slow, clunky tools.

(While it would be fun to dive deeper into the topic of DX in general, I think I'll save that for another blog post -- but if you're as much of a software history nerd as I am, you may enjoy [The evolution of developer experience in the 20th century](https://www.linkedin.com/pulse/evolution-developer-experience-20th-century-stan-james/) by [Stan James](https://twitter.com/wanderingstan))

## Building Tools with Node.js

I first started working with Node around [version 0.4](https://github.com/nodejs/node-v0.x-archive/blob/v0.4.0/ChangeLog) in 2011 and at the time I had absolutely no idea how anything worked. I came from a designer-first frontend background and my knowledge of JavaScript was limited to the context of the [browser](https://www.youtube.com/watch?v=Lsg84NtJbmI).

<aside class="right">If you're new to systems programming altogether you might enjoy this <a href="https://gist.github.com/davemo/3c6042086deff4c2fd8a5f16751050d4" title="So, You want to be a Systems Engineer">gist I created</a> with some learning resources on the topic. Building tools with Node assumes at least some of this knowledge.
</aside>

Jumping into Node was extremely disorienting for me, up was down and left was right, `window` was `global` and there was no `XHR` or `DOM`. Writing modules, packages, and command-line tools was all new to me, yet I was intrigued by the potential to leverage my knowledge of JavaScript within the world of tool building and systems programming.

Around this time I was working with [Searls](https://twitter.com/searls) who created [Lineman](https://www.youtube.com/embed/KERJkJNV5nI) after conversations we had about frustrations I was experiencing with frontend tooling at the time.

This experience was transformative for me because up until that point the tools I was using were clunky, written in other languages I didn't know as well, and incredibly slow. Justins' focus on the DX of Lineman was immediately apparent and the fact that it was written in JavaScript (ok, and a _lot_ of CoffeeScript) made it easy for me to contribute to. It was empowering to have someone was able to listen to my frustrations and translate them into magic on the command-line!

Since then, I've been able to work on some of my own tools, libraries, and plugins while picking up a few tips, tricks, and many opinions along the way. My hope is that sharing my experience will give you a **starting place** I wished I had when learning to build tools in Node and lead you to an enjoyable developer experience doing so.

## Ok, but how do I start?

Great question! It's the same one I had when I was interested in writing command-line tools with Node. The rest of this post will be a guided tutorial that I think will help you get started and answer the following questions:

- How can I **iterate** on a node module locally without publishing to npm?
- How can I test my tool in **another project**?
- How can I **debug** the code while developing?
- How should I **package** things?

<aside>
Keep in mind, <b>I'm biased!</b> If you're experienced and have done this before there's a good chance my approach will probably differ from yours and that's ok. There are many tools and techniques I'm not familiar with -- please let me know on <a href="https://twitter.com/dmosher">twitter</a>. I'm always eager to learn.
</aside>

## Prerequisites

 You'll need the following in order to follow along:

- an installation of `node >= v16` and `npm >= v8`
- a terminal app like `terminal.app` or `powershell`
- your favorite code editor

First, create a folder where you can work. I will be using `~/code/node`. Then, run the following commands in your terminal to create some subdirectories and clone my [workflow template](https://github.com/davemo/nodejs-tool-dev-template).

```shell
$ # create tutorial directory
$ mkdir -p ~/code/node
$ cd ~/code/node

$ # create the my_project directory and initialize it with npm
$ mkdir my_project
$ cd my_project
$ npm init -y
$ cd ..

$ # create the my_tool directory and clone the workflow template
$ mkdir my_tool
$ cd my_tool
$ npx degit davemo/nodejs-tool-dev-template
$ npm i
```

Using the [`tree` command](https://formulae.brew.sh/formula/tree), here's what things should look like.

```shell
$ tree -L 2 ~/code/node

~/code/node
├── my_project
│   └── package.json
└── my_tool
    ├── dist
    ├── index.js          # executable entrypoint file
    ├── lib
    │   └── tool.js       # module that logs to STDOUT
    ├── node_modules
    ├── package-lock.json
    ├── package.json
    └── test

6 directories, 4 files
```

The `my_tool` directory comes with an entrypoint file `index.js` which will be our CLI tool. This entrypoint requires and executes `lib/tools.js` which logs a simple message to `STDOUT` and completes after a delay of 1 second. Here's what those files look like:

```javascript
// my_tool/index.js
#!/usr/bin/env node

require('./lib/tool.js')();
```

```javascript
// my_tool/lib/tool.js
module.exports = function tool() {
  console.log('⏳ CLI tool: working ...')
  setTimeout(function() {
    console.log('✅ CLI tool: done!')
  }, 1000);
}
```

## Iterating locally using `npm link`

Often you will want to test a node module locally without having to publish it.

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

### Step 2: Link-install `my_tool` tool in `my_project`

Next, use `npm link my_tool` from _within_ `my_project` to complete the linking process:

```shell
$ cd my_project
$ npm link my_tool

added 1 package, and audited 3 packages in 516ms

$ ls -la node_modules/
my_tool -> ../../my_tool
```

Now that we've got things linked up, we're ready to start iterating on `my_tool` and testing how it works inside of `my_project`.

## Testing our tool in another project

To work with `my_tool` inside of `my_project` we're going to use [npm scripts](https://docs.npmjs.com/cli/v8/using-npm/scripts) inside `my_project/package.json`. Let's add a script `log_a_message` that invokes `my_tool`:

```json
// my_project/package.json
{
  "name": "my_project",
  "version": "1.0.0",
  "description": "",
  "main": "index.js",
  "scripts": {
    "log_a_message": "my_tool" // add this script
  },
  "keywords": [],
  "author": "",
  "license": "ISC"
}
````

With this script added we can run it using `npm run log_a_message`. If everything is linked correctly you should see something like this when you run the script:


```shell
$ npm run log_a_message

> my_project@1.0.0 log_a_message
> my_tool

⏳ CLI tool: working ...
✅ CLI tool: done!
```

### What happens when we call `npm run log_a_message`?

To better understand what's going on, let's take a look at the `name` and `bin` of the fields within the scaffolded `package.json` that came with the workflow template:

```json
// my_tool/package.json
{
  "name": "my_tool",

  // explicit mapping syntax
  "bin": {
    "my_tool": "dist/index.js" // bin.my_tool invokes dist/index.js
  },

  // implicit mapping syntax
  "bin": "dist/index.js" // package.name invokes dist/index.js
}
```

The `bin` key in `my_tool/package.json` is a mapping of the command name to the local file name that will be executed. In our case, because the name of the package and the command are the same we _could_ also simplify it to use the implicit syntax above but I generally prefer to use the explicit syntax just to make it clear to future readers.

With that in mind, this is roughly what happens when we ran `npm run log_a_message`:

1. npm looks for `scripts.log_a_message` in `my_project/package.json`
1. npm appends `my_project/node_modules/.bin` to the shell's pre-existing `PATH`
1. npm resolves `my_tool` to `my_project/node_modules/.bin/my_tool` which is a symlink to `my_tool/dist/index.js` because of the `bin` mapping.
1. `my_tool/dist/index.js` contains a [unix shebang](https://en.wikipedia.org/wiki/Shebang_(Unix)) `#!/usr/bin/env node`
1. the script is effectively executed with `node my_tool/dist/index.js`

**Phew!** That's a lot of moving parts behind the scenes, but I often find it helpful to understand the layers beneath the abstractions that I'm working with.

To get started

> ncc with build and watch flag
> a command-line tool with a binary
> boilerplate repo cloneable with npx degit
> tests setup with teenytest and testdouble.js