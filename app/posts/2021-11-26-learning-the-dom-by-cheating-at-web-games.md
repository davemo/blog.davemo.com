---
title: "Learning the DOM by Cheating at Web Games"
date: "2021-11-26"
description: "Turning some fun in browser devtools into a learning opportunity."
social_img: "/img/learn-dom-by-cheating/social-card.png"
---

<aside class="tldr">
In which we turn an exploration of a web game into a learning opportunity.
</aside>

I've been on a recent quest to experiment with new frontend frameworks, like [htmx](https://htmx.org) and [solidjs](https://www.solidjs.com), when I came across [mavo](https://mavo.io/) which bills itself as...

> A new, approachable way to create Web applications

It's novel and has some interesting ideas around composing applications using only HTML/CSS, you should check it out!

<aside class="right">
  I'm currently rebuilding my [TBS BattlePlanner](https://tbs.davemo.com) app using Mavo and plan to blog about it when I'm done, so stay tuned.™
</aside>

While exploring, I discovered a [Memory Game](https://dmitrysharabin.github.io/mavo-memory-game/) written in Mavo by one of its maintainers, [Dmitry Sharabin](https://twitter.com/DmitrySharabin), and was pretty impressed with how much interactive behaviour could be achieved with purely declarative markup and styles. As I was playing the game I ended up poking at the internals using my browsers dev tools, mostly because I wanted to see how easy it would be to **cheat** -- my memory game times were _miserable_. 😉

![Image of memory game]

It was a fun little exploration and I thought it might be a useful learning method to teach some DOM concepts so let's get cheatin'!

## Scratching an Itch

Whenever I'm inspired to learn something it's _usually_ because I have an itch that needs to be scratched; curiousity often drives me forward and I find myself circling back at the end to take note of which questions I'd asked myself. In this case, that itch started with a question: I wonder if I can script an automated instant win in the Memory Game? 🤔

To start exploring an answer, I did what I usually do: crack open my browsers dev tools and start poking at things.

![image of browser dev tools looking at memory game]



## How can I get the answers?

## What data structure would be easiest to help me cheat?

## How can I simulate user clicks?

## How do I put it all together?

answer = $$('.card span').reduce((out, c, i) => {
   if(out[c.textContent]) {
     out[c.textContent] = [...out[c.textContent], i+1]
   } else {
     out[c.textContent] = [i+1];
   }
   return out;
}, {})

answer = $$('.card span').reduce((out, c, i) => {
  out[c.textContent] = [...(out[c.textContent] || []), i+1]
  return out;
}, {})

{
    "🐯": [
        1,
        9
    ],
    "🐵": [
        2,
        7
    ],
    "🐼": [
        3,
        8
    ],
    "🐶": [
        4,
        12
    ],
    "🐭": [
        5,
        11
    ],
    "🐱": [
        6,
        16
    ],
    "🐹": [
        10,
        14
    ],
    "🐻": [
        13,
        15
    ]
}

Object.values(answer).forEach(pair => {
  $(`.card:nth-child(${pair[0]})`).click();
  $(`.card:nth-child(${pair[1]})`).click();
});

Object.values($$('.card span').reduce((out, c, i) => {
   if(out[c.textContent]) {
     out[c.textContent] = [...out[c.textContent], i+1]
   } else {
     out[c.textContent] = [i+1];
   }
   return out;
}, {})).forEach(pair => {
  $(`.card:nth-child(${pair[0]})`).click();
  $(`.card:nth-child(${pair[1]})`).click();
});

Object.values($$('.card span').reduce((out, c, i) => {
  out[c.textContent] = [...(out[c.textContent] || []), i+1]
  return out;
}, {})).forEach(pair => {
  $(`.card:nth-child(${pair[0]})`).click();
  $(`.card:nth-child(${pair[1]})`).click();
});