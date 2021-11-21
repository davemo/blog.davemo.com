---
title: "React Performance Analysis"
date: "2017-11-07"
description: "A screencast on performance profiling and anlysis with React"
---

<aside class="tldr">
  A screencast that covers a number of techniques on evaluating the performance of React applications.
</aside>

React is frequently touted as being performant due to the optimizations of its Virtual DOM technique, yet all to often this is used by developers as a crutch to avoid thinking about the performance of their code _at all_. This generally leads to performance problems in React apps of any significant scale.

With the proliferation of React applications in the wild, I thought it would be a good idea to examine some techniques for evaluating the performance of React Components.

This screencast covers a number of techniques for constructing components, but also shows how to evaluate performance objectively and make informed refactoring decisions.

<iframe src="https://www.youtube.com/embed/sVDnCMIkmTM?wmode=transparent" allowfullscreen frameborder="0" height="417" width="515"></iframe>

## Screencast Outline

1. Introduction

  * A Common UI Scenario for React Components -> Large Data Tables
  * Developer Default: Google/Stack Overflow Driven Development
  * The Quest for a pre-built Library

2. Performance Goals

  * Important Metrics: TTI (time to interactive), TTFMP (time to first meaningful paint)
  * Setting a Frame Budget: (60fps / 16.7ms) might not always be feasible
  * The Feedback Loop: Experiment, Evaluate

3. React Development Patterns

  * Start BIG: 1 component, 1 render method, then profile
  * Decompose: limit the surface area of your component by thinking hard about props, then profile
  * Optimize by:
    * Reducing JS Execution: work the browser doesn't have to do doesn't need to be optimized
    * Reducing Surface Area for Change: small components, limited surface area, small lists of props
    * Keep `render` methods simple and _mostly_ static

## Code

https://github.com/davemo/react-performance-analysis