> Two years in the making; just released and fresh off the presses it's yet another screencast covering everybodys favorite enterprise JS framework: Angular JS!

<iframe src="https://www.youtube.com/embed/4zG8SfucUzg?wmode=transparent" allowfullscreen frameborder="0" height="417" width="500"></iframe>

In all seriousness, I had a hard time considering whether or not to publish this screencast because I found myself questioning whether the content would still be relevant almost two years later. However, in revisiting all the comments and questions about the alluded-to "part 2" from the first video I felt like there were still valuable things to talk about. At the heart of this screencast is discussion around what I consider **one of the most valuable features of angular**: the ability to use custom elements as a domain-specific language (DSL) to ease the **wrapping and use of 3rd party libraries**.

This screencast continues the examination of some of the advanced features in Angular from [Advanced Directives with Angular JS](https://blog.davemo.com/posts/2015-02-13-advanced-directives-with-angular-js) and expands by tackling some of the issues raised in Part 1 including:

- bugfixes for the inline editor
- auto toggling of editing state using CSS content generation and the angular $scope
- leveraging the DSL from the first screencast as an interface to a 3rd party JavaScript data grid component: js-grid

If you're interested in some more context prior to watching, check out my other [angular screencasts](https://www.youtube.com/c/DavidMosher) and an earlier post on the [power of web components as abstractions](https://blog.davemo.com/posts/2013-06-26-what-polymer-and-angular-tell-us-about-the-future-success-of-the-web-platform-and-javascript-frameworks).

Hopefully the next screencast series won't take 2 years to complete ;)

# Code

- bugfix: don’t re-add and compile editors https://github.com/davemo/advanced-directives-with-angular-js/commit/4efc9edfacc3cee791f155d52bf517a7ab251586
- feature: swap arrow on editor state https://github.com/davemo/advanced-directives-with-angular-js/commit/2f046f51dda4b54891353b7ec047b3a6e381792d
- feature: leverage a 3rd party lib using the same DSL https://github.com/davemo/advanced-directives-with-angular-js/pull/2/files