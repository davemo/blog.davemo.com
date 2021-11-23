---
title: "Developer Experience, Feedback Loops, and an Enjoyable Workflow for Node.js Tool Development"
date: "2021-11-20"
description: "A tutorial that walks you through creating a workflow for building command-line tools with Node.js with an emphasis on good developer experience and fast feedback loops."
social_img: "/img/nodejs-tooling-development-workflow/social-card.png"
---

<aside class="tldr">
If you're experienced and prefer code to prose, you can explore the <a href="https://github.com/davemo/nodejs-tool-dev-template">code on github</a> or <code>npx degit davemo/nodejs-tool-dev-template</code>.
</aside>

There's been a lot of focus on the topic of DX or developer experience recently, which is _great_ because it's something that I'm passionate about improving on the teams I work with. So passionate, in fact, that I recently transitioned out of a customer-focused engineering role into one focused on developers, tooling, and infrastructure.

Now you might be asking yourself, 'What does DX _actually_ mean?', and you would be justified in asking -- I've heard varied interpretations of the term.

[Jean Yang](https://twitter.com/jeanqasaur) defines it this way in [The Case for Developer Experience](https://future.a16z.com/the-case-for-developer-experience/):

> What I mean by **developer experience** is the sum total of **how** developers interface with their **tools**, end-to-end, day-in and day-out.

I think that a big part of the "how" there is the concept of _feedback loops_. Good developer tools provide affordances that reduce cognitive load, surface key information at the right time, but most importantly, good tools prioritize keeping feedback loops _fast_ -- and nothing depletes my [cognitive batteries](https://en.wikipedia.org/wiki/Ego_depletion) _faster_ than slow, clunky tools.

## Building Tools with Node.js

I first started working with Node around [version 0.4](https://github.com/nodejs/node-v0.x-archive/blob/v0.4.0/ChangeLog) in 2011 and at the time I had absolutely no idea how anything worked. I came from a designer-first frontend background and my knowledge of JavaScript was limited to the context of the [browser](https://www.youtube.com/watch?v=Lsg84NtJbmI).

<aside class="right">If you're new to systems programming altogether you might enjoy <a href="https://gist.github.com/davemo/3c6042086deff4c2fd8a5f16751050d4" title="So, You want to be a Systems Engineer">this gist</a> I put together with a learning path. Building tools with Node assumes at least some of this knowledge.
</aside>

Jumping into Node was extremely disorienting for me, up was down and left was right, `window` was `global` and there was no `XHR` or `DOM`. Writing modules, packages, and command-line tools was all new to me, yet I was intrigued by the potential to leverage my knowledge of JavaScript within the world of tool building and systems programming.

Around this time I was working with [Searls](https://twitter.com/searls), who created [Lineman](https://www.youtube.com/embed/KERJkJNV5nI) after I shared frustrations with most of the frontend tooling I was using.

This experience was transformative for me because up until that point the tools I was using were clunky, written in other languages I didn't know as well, and incredibly slow. Justin's focus on the DX of Lineman was immediately apparent and the fact that it was written in JavaScript (ok, and a _lot_ of CoffeeScript) made it easy for me to contribute to. It was empowering to have someone listen to my frustrations and translate them into magic on the command-line!

Since then, I've been able to work on some of my own tools, libraries, and plugins while picking up a few tips, tricks, and many opinions along the way. My hope is that sharing my experience will give you the **starting place** I wished for when learning to build tools in Node and lead you to a more enjoyable developer experience.

## Ok, but how do I start?

Great question! It's the same one I had when I was interested in writing command-line tools with Node. The rest of this post will be a guided tutorial that I think will help you get started and answer the following questions:

- How can I [iterate](#iterating-locally-using-npm-install-dir) on a node module locally without publishing to npm?
- How can I test what I'm building in [another project](#testing-our-tool-in-another-project)?
- How can I [debug](#development-workflow-watch-build--debug) the code while developing?
- How should I [package](#packaging-with-vercelncc-and-npm) things?

<aside>
Keep in mind, <b>I'm biased!</b> If you're experienced and have done this before there's a good chance my approach will probably differ from yours and that's ok. There are many tools and techniques I'm not familiar with -- please let me know on <a href="https://twitter.com/dmosher">twitter</a>. I'm always eager to learn.
</aside>

## Prerequisites

 You'll need the following in order to follow along:

- an installation of `node >= v16` and `npm >= v8`
- a terminal app like `terminal.app` or `powershell`
- your favorite code editor
- `optional` a checkout of the [full example](https://github.com/davemo/blog-example-nodejs-workflows) repo

If you prefer to follow along step-by-step, let's get started by running the following commands to create a workspace folder for the tutorial.

I like to use `~/code/node`, but you can use whatever you are most comfortable with.

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

Using the `tree` [command](https://formulae.brew.sh/formula/tree), we can visualize the folder structure.

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

The `my_tool` directory comes with an entrypoint file `index.js` which will be our CLI tool. This entrypoint requires and executes `lib/tools.js` which logs a simple message to `STDOUT` and completes after a delay of 1 second.

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

## Iterating locally using `npm install <dir>`

Often you will want to test a node module in another project locally without having to publish it. There are a few ways to do this but we want to optimize for the best developer experience in our workflow, so I'm going to focus on using `npm install <dir>`.

<aside>
We could also achieve this using <a href="https://docs.npmjs.com/cli/v8/commands/npm-link">npm link</a>, but that involves extra steps and requires us to remember that we've linked things and it ends up just being a lot more to manage. Another alternative that I've seen is <a href="https://pnpm.io/cli/link">pnpm link</a>, but that is beyond the scope of this blog post.
</aside>

### Install `my_tool` from within `my_project`

```shell
$ cd my_project
$ npm install ../my_tool

added 1 package, and audited 3 packages in 634ms
```

Installing a package this way causes _three_ side-effects that we should know about.

```shell
$ # a symbolic link for my_tool is created in node_modules
$ ls -la my_project/node_modules
my_tool -> ../../my_tool

$ # a symbolic link for the executable is created in node_modules/.bin
$ ls -la my_project/node_modules/.bin
my_tool -> ../my_tool/dist/index.js

$ # my_tool is added to dependencies mapped to a relative file path
$ cat package.json | grep -A2 dependencies
"dependencies": {
  "my_tool": "file:../my_tool"
}
````

> The addition of the relative `file:` path in `dependencies` is nice because it serves as a physical reminder that we are in development mode; something we don't get using `npm link`.

Now that we've got things installed, we're ready to start iterating on `my_tool` and testing how it works inside of `my_project`.

## Testing our tool in another project

To work with `my_tool` inside of `my_project` we're going to use [npm scripts](https://docs.npmjs.com/cli/v8/using-npm/scripts) inside `my_project/package.json`. Let's add a script `log_a_message` that invokes `my_tool`.

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

We can now execute `npm run log_a_message` to invoke `my_tool`.

```shell
$ npm run log_a_message

> my_project@1.0.0 log_a_message
> my_tool

⏳ CLI tool: working ...
✅ CLI tool: done!
```

### What happens when we call `npm run log_a_message`?

To better understand what's going on, let's take a look at the `name` and `bin` keys within the scaffolded `package.json` that came with the workflow template.

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

> In our case, because the name of the package and the command are the same, we _could_ simplify using the `implicit` syntax, but I generally prefer to use the `explicit` syntax just to make it clear to future readers.

The `bin` key in `my_tool/package.json` is a mapping of the command name (`my_tool`) to the local file name (`dist/index.js`) that will be executed.

With that in mind, this is roughly what happens when we run `npm run log_a_message`:

- npm looks for `scripts.log_a_message` in `my_project/package.json`
- npm appends `my_project/node_modules/.bin` to the shell's pre-existing `PATH`
- npm resolves `my_tool` to `my_project/node_modules/.bin/my_tool` which is a symlink to `my_tool/dist/index.js` because of the `bin` mapping.
- `my_tool/dist/index.js` contains a [unix shebang](https://en.wikipedia.org/wiki/Shebang_(Unix)) `#!/usr/bin/env node`
- the script is effectively executed with `node my_tool/dist/index.js`

<aside><strong>Phew!</strong> That's a lot of moving parts behind the scenes, but I often find it helpful to understand the layers beneath the abstractions that I'm working with.</aside>

## Development workflow: `(watch, build) + (debug)`

With `my_tool`installed within `my_project`, the next thing we might want to do is debug our tooling code as we iterate while developing. There are a few included npm scripts in the workflow template that we'll find within `my_tool/package.json`.

```json
"scripts": {
  // watch: runs the build, compiling on every change
  "watch": "npm run build -- -w",

  // build: a one time compile using @vercel/ncc
  "build": "ncc build index.js -o dist --source-map",

  // debug: open ndb to debug our compiled tool
  "debug": "ndb dist/index.js"
}
```

### Watch + Build with `@vercel/ncc`

The `watch` target here invokes `build` and passes along the `-w` parameter which tells `ncc` that it should watch for file changes and recompile every time a change is detected.

The `build` target invokes `ncc`, which traverses the dependency graph starting at our `index.js` entrypoint, and compiles everything it finds (including dynamically imported things) into a single file with all dependencies inlined, kind of like `gcc`.

To kick things off, run `npm run watch` from within `my_tool`.

```shell
$ cd my_tool
$ npm run watch

> my_tool@1.0.0 watch
> npm run build -- -w

> my_tool@1.0.0 build
> ncc build index.js -o dist --source-map "-w"

ncc: Version 0.31.1
ncc: Compiling file index.js into CJS
File change, rebuilding...
 2kB  dist/index.js
 2kB  dist/index.js.map
40kB  dist/sourcemap-register.js
42kB  [113ms] - ncc 0.31.1
Watching for changes...
````

I like starting with this "watch-build" workflow when developing for a few reasons:

- ✅ It compiles on every file change and compilation is effectively the first unit test; this gains us confidence that we aren't introducing simple bugs as we develop.

- 📦 It sets us up to be ready to publish our module to npm as soon as we are done developing; the `dist` folder is the only thing we need to upload to npm.

- ⏭ `ncc` generates sourcemaps, so we get the same DX benefits of debugging against `my_tool/index.js` in concert with the compilation benefits above.

### Debugging with `ndb`

The `debug` target spins up `ndb` pointing at our single compiled file in `dist/index.js`. The feedback loop when developing and debugging is nearly instant, and `ndb` includes some really nice DX features which we'll look at shortly.

First, let's add a `debugger` statement within `my_tool/lib/tool.js` knowing that it will be compiled into `dist/index.js` automatically by our Watch + Build process.

```javascript
// my_tool/lib/tool.js
module.exports = function tool() {
  console.log('⏳ CLI tool: working ...')
  debugger; // add a debugger statement here
  console.log('another one');
  setTimeout(function() {
    console.log('✅ CLI tool: done!')
  }, 1000);
}
```

Then, in another terminal window let's spin up `ndb` using `npm run debug`.

```shell
$ npm run debug

> my_tool@1.0.0 debug
> ndb dist/index.js

Downloading Chromium r624492...
Chromium downloaded to /Users/davidmosher/code/node/my_tool/node_modules/carlo/lib/.local-data/mac-624492
⏳ CLI tool: working ...
````

> The first time you run the `debug` target `ndb` will download Chromium.

With this process launched you should see a Chromium window pop up.

![The Chromium window launched by ndb](/img/nodejs-tooling-development-workflow/ndb-example.png)

This is where we can see some of the `ndb` DX specifics I mentioned earlier that make this workflow so nice:

- 📃 Notice the `NPM Scripts` tab? This allows you to repeatedly invoke any npm script right from the GUI. This is really handy for making changes and then testing them immediately.

- 🔁 `ndb` stays launched and available for you to re-run any of those npm scripts; this is much nicer than `node --inspect-brk` which exits after the current debug stack is completed.

- ⏭ We can see those sourcemaps I mentioned before at work here, `lib/tool.js` shows up in the source pane even though we're debugging `dist/index.js`.

- 🐛 Finally, all of your other Chrome DevTools muscle memory applies just the same here as it does when debugging client-side JavaScript! The step-debugger, sources panel, and snippets can all come in handy working here in a node-based JS context.

## Packaging with `@vercel/ncc` and `npm`

When you've finished creating your command-line masterpiece the next thing you may want to do is publish it to the npm registry so that others can `npm install` it. Thankfully, this step is easy because we already configured `ncc` to build for production in the `dist` folder via our `build` npm script.

The last thing to consider is how to minimize the size of our package when a user installs it with `npm install`, and this has already been done for us in the `files` key within `my_tool/package.json` key.

```json
{
  "name": "my_tool",
  "version": "1.0.0",
  "description": "a template for developing node.js command-line tools",
  "main": "index.js",
  "bin": {
    "my_tool": "dist/index.js"
  },
  "files": [ // manages which files are published to npm
    "dist"
  ],
  // ...
}
```

> NPM has some [documentation](https://docs.npmjs.com/cli/v8/configuring-npm/package-json#files) on `files` that you may find helpful.

Limiting `files` to just the `dist` directory ensures that we keep our package as small as possible, which is already taken care of thanks to `ncc` producing a single file. If you want to double check to see _exactly_ which files npm would add to the package, you can run `npx npm-packlist`.

```shell
$ npx npm-packlist

index.js
package.json
dist/index.js
dist/index.js.map
dist/sourcemap-register.js
````

Our last step before publishing will be to remove the `private: true` flag from `package.json`, which I added so nobody accidentally published the workflow template. Once that's done, then you can simply `npm publish` and your minimal package will be uploaded to the npm registry.

<aside>If you don't provide a tag when you publish, npm will automatically assign your published package to the <code>latest</code> specifier, which would allow you to install it using <code>npm install my_tool@latest</code>.</aside>

## Wrapping up

This concludes my tutorial on an enjoyable workflow for Node.js tool development. I hope you found this useful and that you find the experience of developing tools in this way enjoyable and the feedback loop fast and efficient.

If you have questions or wish to provide feedback, please reach out to me on [twitter](https://twitter.com/dmosher). I would love to hear from you!

Happy tool-making. 💚