---
title: "What Polymer and Angular tell us about the future success of the Web Platform and JavaScript Frameworks"
date: "2013-08-08"
---

> Yehuda Katz recently gave a talk entitled ["The Future of the Client-Side
Web"](https://www.youtube.com/watch?v=EcyxXPILO8E) in which he detailed the
current challenges that web standards bodies face when trying to design APIs
for web developers to use. In this talk, Yehuda also highlighted Google's
recently announced [Polymer Project](https://www.polymer-project.org/) as a good
example of the right way to push the web platform forward.

Polymer provides a "low enough" level API that gives web developers the power
to redefine the way they write markup using the power of newer features coming
to JavaScript in [ES6](https://tc39wiki.calculist.org/es6/). The specifics of
the implementation aren't relevant to what I want to say here, but Yehuda does
a great job covering the details at a high level in the video; I suggest you
watch it if they interest you.

What I found interesting was the _message_ that was at the heart of the talk,
here's my paraphrased version:

> Web Platform standards bodies need to focus less on getting implementations
> of new APIs right the first time (hello
> [AppCache](https://www.w3.org/Bugs/Public/show_bug.cgi?id=14702)) and instead
> provide web developers with a set of lower level APIs that are exposed to
> JavaScript. When this approach has been followed, developers are capable of
> iterating far faster than standards bodies which results in consensus on API
> design being reached faster and with less upfront design.

This is a fundamental shift in thinking that should be embraced and I believe
this approach has already been validated by a number of well-known JavaScript
libraries.

# The Backbone Lesson

Since its release, [Backbone](https://documentcloud.github.io/backbone/) has
exploded in popularity and many [other](https://github.com/chaplinjs/chaplin)
[frameworks](https://github.com/marionettejs/backbone.marionette) have since
been built on top of the low-level components it provides. [Jeremy
Ashkenas](https://www.twitter.com/jashkenas) and the team at [Document
Cloud](https://www.documentcloud.org) did an amazing job of releasing a set of
components that can be adapted to fit almost any scenario when building a web
application&mdash;from simple uses of Backbone.View inside an existing legacy
application all the way up to writing a self-contained application that runs in
the browser.

When I first started working in Backbone almost two years ago, I remember
feeling overwhelmed at how I was supposed to use all the pieces provided. I
believe this speaks to the essence of how Backbone was created, and looking
back now it is clear to me that Backbone follows the design model that Yehuda
praises in his talk; it gave us a low-level set of components and didn't really
enforce any particular design decisions on how to use them&mdash;aside from an
important guiding principle: get your data out of the DOM.

# The Ember Conundrum

A recent blog post comparing [Ember](https://emberjs.com/) and
Angular&mdash;originally entitled ["AngularJS vs Ember, It's not even
close"](https://eviltrout.com/2013/06/15/ember-vs-angular-its-not-even-close.html)&mdash;highlights
some perceived shortcomings of Angular, chief among them being there are too
many pitfalls in the simplistic features Angular provides and the Angular team
should strive to provide higher-level conventions/components that developers
can follow. While Yehuda didn't write the comparison post, the point of view
expressed by the author really struck me as being in stark contrast to the
decentralized/low-level API design approach that Yehuda extols the virtues of
in his talk: success is realized when developers are given access to low-level
components without many opinions on how they should be used. Designing a
powerful, approachable, easy-to-learn-difficult-to-master framework _is_ hard,
but Ember is _very_ opinionated.

It seems to me like the Ember team and contributors would be better served by
following these design goals; spending more time observing how web developers
use their low-level APIs when crafting solutions and less time trying to get a
high-level rich-web application framework right the first time. Perhaps this is
why the path to Ember's 1.0 release has been so full of frequent, [backwards
compatibility breaking](https://meta.stackoverflow.com/a/163861) API changes.

# The Angular Approach

Initially I was skeptical about the power of
[Angular](https://www.angularjs.org), having spent a good 18 months of my life
invested in writing applications with Backbone I wasn't eager to make a jump to
another framework. Thankfully my skepticism was quickly swept aside as I
discovered the beauty in the simplicity of the Angular API. With Angular, I
don't have to extend framework built-in objects or methods; I can just use
POJSO's (Plain Old JavaScript Objects) and functions. I also don't have to
spend a lot of time thinking about how to structure my application thanks to
[`angular.module`](https://docs.angularjs.org/guide/module) and built-in
[dependency injection](https://docs.angularjs.org/guide/di). Angular _really_
hits the sweet spot between low-level components and _tightly scoped_
high-level abstractions. It provides high-level features that each have a
singular focus as well as low-level components that I can craft into
domain-specific solutions within my applications.

The ability to craft custom markup through
[`angular.directive`](https://docs.angularjs.org/guide/directive) is an
interesting high-level piece in that it has the power to create custom
components that are as coarse or granular as you need them to be. Angular is
_just_ opinionated enough that it allows developers to work with the low-level
components provided to craft higher level abstractions. In fact, I think that
is the core benefit of Angular. Having the power to abstract:

```html
<div id="chart" data-type="bar">
  <div class="legend"></div>
  ... lots of other stuff
</div>
```

into

```html
<bar-chart></bar-chart>
```

is an incredibly powerful idea.

# Web Components and the future of Markup

One of the most exciting changes to the Web Platform in the last five years is
the upcoming [Web
Components](https://www.w3.org/TR/2013/WD-components-intro-20130606/) spec.
[Eric
Bidelman](https://www.google.ca/url?sa=t&rct=j&q=&esrc=s&source=web&cd=1&cad=rja&ved=0CC0QFjAA&url=https%3A%2F%2Ftwitter.com%2Febidel&ei=_EDLUbuIK8iHywGUuYHoDg&usg=AFQjCNHgffvpgL9vHcpCK96uvkRqTmUkzg&bvm=bv.48340889,d.aWc)
gave a [great overview](https://www.youtube.com/watch?v=fqULJBBEVQE) of it
during Google IO this year and [Alex Komoroske](https://twitter.com/jkomoros)
and [Matthew McNulty](https://twitter.com/mattsmcnulty) had an [amazing
demo](https://www.youtube.com/watch?v=0g0oOOT86NY) that showcased some of the
capabilities. I'm excited about Web Components because it will allow web
developers to experiment at a lower-level by reshaping the way that we write
markup. It will also offer true encapsulation on the web, a feature that has
been sorely lacking.

It seems like the lessons the Angular team have learned are helping to shape
the direction of Web Components. In fact, [Miško
Hevery](https://twitter.com/mhevery) from the Angular team has [this to
say](https://groups.google.com/forum/#!msg/polymer-dev/4RSYaKmbtEk/uYnY3900wpIJ)
on Angular + Web Components:

> Web Components (Polymer, Ember, or any other framework/library) will work
 seamlessly within Angular apps and directives.

> Components written in Angular will export to Web Components (to be used by
 Polymer, Ember, or any other framework/library).

The awesome thing about Angular and Polymer is that you can use them to achieve
these kinds of markup abstractions in your applications right now, along with
all the other great features they provide. I'm eager to see how the lower-level
features in ES6 and low-level libraries like Polymer are going to be used by
developers to create even more amazing frameworks in the future.

# Moving the Web Forward with Low-Level APIs

I think Yehuda has it right; standards bodies need to focus less on getting
high-level APIs right up front and more on providing developers with enough
low-level APIs with which to experiment. The same principle applies to the
design of JavaScript application frameworks. My hope is that the standards
bodies _and_ JavaScript framework authors embrace this decentralized approach
to design going forward. Ideally this will move the web development community
beyond rhetoric and zero-sum thinking, and into an age of innovation.
