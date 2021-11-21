---
title: "Advanced Directives with AngularJS (Part 1)"
date: "2015-02-13"
description: "Part 1 of a screencast series looking at advanced directives with AngularJS."
---

<aside class="tldr">
AngularJS treats HTML as a DSL, allowing us to create abstractions using markup through its concept of directives.
</aside>

This screencast examines some of the more advanced features in Angular, specifically Directives. We'll see how we can leverage the power of custom elements and attributes to map Domain Specific concepts through HTML and translate those into Value Objects in our Domain, resulting in cleaner HTML output. Also discussed: complexity, creating a DSL with directives, debugging techniques, and other tips and tricks.

If you're interested in some more context prior to watching, check out my other [angular screencasts](https://www.youtube.com/user/vidjadavemo/videos) and an earlier post on the [power of web components as abstractions](https://blog.davemo.com/posts/2013-06-26-what-polymer-and-angular-tell-us-about-the-future-success-of-the-web-platform-and-javascript-frameworks). This screencast covers:

* html as a dsl
* abstractions in html
* [$compile](https://docs.angularjs.org/api/ng/service/$compile)
* [$templateRequest](https://docs.angularjs.org/api/ng/service/$templateRequest)
* [$templateCache](https://docs.angularjs.org/api/ng/service/$templateCache)
* [directive definition object](https://docs.angularjs.org/api/ng/service/$compile#directive-definition-object)
* [requiring other directives](https://docs.angularjs.org/api/ng/service/$compile#-require-)
* [directive communication ($scope.$broadcast, $scope.$on)](https://docs.angularjs.org/guide/scope#scope-events-propagation)

<iframe src="https://www.youtube.com/embed/Ty8XcASK9js?wmode=transparent" allowfullscreen frameborder="0" height="417" width="515"></iframe>

## Code

- https://github.com/davemo/advanced-directives-with-angular-js

## Extra Credit

Some things in the screencast aren't complete and some things could definitely done better. This section is a challenge to you, the reader/watcher to improve the code and level up your knowledge in the process! Try and tackle some of these challenges if you want:

* Bugfix: the editor currently shows up multiple times, fix it so this doesn't happen (hint: maybe an 'edit' state that's tracked could help the directive know if it should execute `.insertAfter`)
* Feature: make the expandy arrow thing point down when expanded and to the right when collapsed.

## Resources

This is part of a screencast series on Angular JS

1. [Intro to Angular JS](http://www.youtube.com/watch?v=8ILQOFAgaXE)
1. [End to End with Angular JS](http://www.youtube.com/watch?v=hqAyiqUs93c)
1. [Security with Angular JS](http://www.youtube.com/watch?v=18ifoT-Id54)
1. [Frontend Workflows with Grunt and Angular JS](http://www.youtube.com/watch?v=fSAgFxjFSqY)
1. [Testing Strategies for Angular JS](https://www.youtube.com/watch?v=UYVcY9EJcRs)
1. [Advanced Directives with Angular JS (Part 1)](https://www.youtube.com/watch?v=Ty8XcASK9js)
1. [Advanced Directives with Angular JS (Part 2)](https://www.youtube.com/watch?v=4zG8SfucUzg)
