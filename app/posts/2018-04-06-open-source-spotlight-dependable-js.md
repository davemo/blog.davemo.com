<hr>

**This post was originally published on [blog.testdouble.com](https://blog.testdouble.com/posts/2018-04-06-open-source-spotlight-dependable-js/)**

<hr>

Recently, [Michael Schoonmaker](https://twitter.com/Schoonology), [Joshua Starkey](https://twitter.com/primarilysnark), and [myself](https://twitter.com/dmosher) got together to brainstorm some improvements we wanted to make to an open source library called Dependable that we had used on a client project.

[Dependable](https://github.com/testdouble/dependable) is billed as "A minimalist dependency injection framework for node.js", but I feel like it only took on the "minimalist" moniker after we shipped version 2.0 just a few weeks ago. As we sat down to discuss what we wanted to do there were a number of questions that shook out that I feel need to be asked by any team working on an open source project:

* How can we make this smaller?
* What features are core and what can we prune?
* How can we write the test-suite in a way that demonstrates real-world examples?
* What should the README communicate?
* How are we going to maintain this going forward?

As we worked towards the backlog of features, we built up a list of _nice-to-haves_ and _must-haves_, choosing to defer the former and focus our efforts on the latter. [Github Projects](https://github.com/testdouble/dependable/projects/1) actually worked pretty well for a lightweight project management tool.

![Github Projects](/img/open-source-spotlight-dependable-js/github-projects-dependable.png)

# Limiting API Surface Area

One of our stated goals was to reduce the surface area of dependable in order to eliminate complexity in the codebase. The 1.0 release of dependable included a public API with 6 methods on the dependency inversion `container` and our rewrite whittled this down to 4. Choosing to have this discussion early allowed us to focus on what the most valuable parts of the API were, using our experience of real-world use within consulting projects to help guide us.

| 1.0 Public API  | 2.0 Public API |
| ------------- | ------------- |
| `container.register(name, func)`  | `container.factory(name, func)`  |
| `container.register(hash)` | `container.constant(name, object)` |
| `container.load(fileOrFolder)` | removed |
| `container.get(name, overrides = {})` | `container.get(name, overrides = {})` |
| `container.resolve(overrides={}, cb)` | removed |
| `container.list()` | removed |
| non-existent | `container.getSandboxed(name, overrides={})`|

With the API sufficiently whittled down, we also set ourselves to renaming the methods in the public API in order to better reveal the intent for each method and avoid violating [SRP](https://en.wikipedia.org/wiki/Single_responsibility_principle) (which some of the 1.0 API methods had done via overloading). `container.register(hash)` became `container.constant(name, object)`, and `container.register` was renamed simply to `container.factory`. We deliberated for a while over naming but felt that `.factory` and `.constant` were terms that were familiar enough in the context of dependency injection and more descriptive than their 1.0 counterparts.

# Rewriting Source and Test

Dependable 1.0 was written in CoffeeScript which we felt would limit options for potential future contributors. We chose to rewrite the library in ES6 and use [standard](https://standardjs.com/) to manage formatting the code for us. It becomes much easier for future contributors to submit patches when the tooling in an open source project handles formatting of the code.

| 1.0 LOC (index.coffee) | 2.0 LOC (index.js) |
| ------------- | ------------- |
| 134 | 99 |

The test-suite took slightly longer to rewrite due to the removal of `container.load(fileOrFolder)`. We felt that this method complected the 1.0 codebase and was syntactic sugar for what could be accomplished by a user via loading one or many files externally using `require` or `import` and then invoking `container.factory(name, func)` within the context of a call to `.map`. In addition to translating the `.coffee` test sources to `.js`, we also reorganized the test examples themselves to better communicate the intended use of dependable.

| 1.0 Test LOC (multiple .coffee files) | 2.0 Test LOC (test.js) |
| ------------- | ------------- |
| ~380 | 259 |

A consistent use of objects from a real world scenario involving a `Logger`, `Router`, and `Formatter` in the context of an `App` was used throughout the test-suite. I've found that I'm much more likely to contribute to open source projects that have a well architected test suite with meaningful examples.

```javascript
it('should register a factory with a single dependency', function () {
  subject.factory('logger', function () {
    return 'message'
  })
  subject.factory('app', function (logger) {
    return logger
  })
  assert.equal(subject.get('app'), 'message')
})
```

In addition, we added first-class support for isolation testing via `container.getSandboxed` which should be used during testing to ensure that a module under test has been completely isolated.

# Closing Thoughts & Recommended Reading

At Test Double we are proud of our commitment to open source and we take pride in trying to be thoughtful in the way we approach open source stewardship. If you share these values and are interested in joining us you should [reach out](http://testdouble.com/join/), we're hiring!

If you aren't familiar with the concept or benefits of Dependency Injection these are some great followup resources to get you thinking:

* [Inversion of Control Containers and the Dependency Injection pattern](https://martinfowler.com/articles/injection.html)
* [Inversion of Control, The UI Thread and Backbone.JS Views](https://www.youtube.com/watch?v=mU1JcPikdMs)
