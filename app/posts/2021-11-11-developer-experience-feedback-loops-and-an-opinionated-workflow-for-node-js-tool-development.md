---
title: "Developer Experience, Feedback Loops, and an Opinionated Workflow for Node.js Tool Development"
date: "2021-11-11"
---

There's been a lot of focus on the topic of DX or developer experience recently, which is _great_ because it's something that I'm passionate about improving on the teams I work with. So passionate, in fact, that I recently transitioned out of a customer-focused engineering role into one focused on developers, tooling, and infrastructure.

Now you might be asking yourself, 'What does DX _actually_ mean?', and you would be justified in asking -- I've heard varied interpretations of the term. I particularly like this laser-focused definition from [Jean Yang](https://twitter.com/jeanqasaur) in her recent post [The Case for Developer Experience](https://future.a16z.com/the-case-for-developer-experience/):

> What I mean by **developer experience** is the sum total of **how** developers interface with their tools, end-to-end, day-in and day-out.

I think that a big part of the "how" that Jean mentions is the concept of _feedback loops_. Good developer tools provide affordances to reduce cognitive load, surface key information at the right time, and prioritize keeping feedback loops fast; all are important parts of a good developer experience but nothing depletes my [cognitive batteries](https://en.wikipedia.org/wiki/Ego_depletion) faster than slow tools and confusing workflows. 😤

(While it would be fun to dive deeper into the topic of DX in general, I think I'll save that for another blog post -- but if you're as much of a software history nerd as I am, you may enjoy [The evolution of developer experience in the 20th century](https://www.linkedin.com/pulse/evolution-developer-experience-20th-century-stan-james/) by [Stan James](https://twitter.com/wanderingstan))

## I can write command-line tools with... JavaScript?

I first started working with [Node](https://nodejs.org) around [version 0.4](https://github.com/nodejs/node-v0.x-archive/blob/v0.4.0/ChangeLog) in 2011 and at the time I had absolutely no idea how anything worked. I was coming from a designer-first frontend background and my knowledge of JavaScript was limited to the execution context of the [web browser](https://www.youtube.com/watch?v=Lsg84NtJbmI).

Jumping into Node was extremely disorienting for me, up was down and left was right, `window` was `global` and there was no `XHR` or `DOM`. Writing modules, packages, and command-line tools were all new to me, yet I was intrigued by the possibility to leverage my knowledge of JS _and_ expand into the world of tool building and systems programming.

Around this time I had the great fortune to work with and be mentored by [Justin Searls](https://twitter.com/searls), and it wasn't long after that he created [LinemanJS](https://www.youtube.com/embed/KERJkJNV5nI) based on early conversations we had and frustrations I shared regarding frontend tooling at the time. (If you haven't heard of Lineman, it's a command-line tool for building frontend apps that got reasonably popular in our consulting circle around 2013. It still works and it's what's [powering this blog](https://github.com/linemanjs/lineman-blog-template/)).

## Node.js Tool Development


> ncc with build and watch flag
> a command-line tool with a binary
> boilerplate repo cloneable with npx degit
> tests setup with teenytest and testdouble.js