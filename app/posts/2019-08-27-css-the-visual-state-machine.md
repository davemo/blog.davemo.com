---
title: "CSS: The Visual State-Machine"
date: "2019-08-27"
---

<aside class="tldr">Using Svelte, we reimagine the presentation layer of a web application as a state machine.</aside>

Thinking of web applications in terms of [state machines](https://en.wikipedia.org/wiki/Finite-state_machine) is [not a new idea](https://www.techrepublic.com/article/set-up-web-applications-as-finite-state-machines/); in fact, it has become so popular in the past few years that teams are spending increasingly more time breaking down their application into states managed by front-end frameworks.

Whether you use [Redux](https://redux.js.org/), [MobX](https://mobx.js.org), or even perhaps something framework-agnostic like [xState](https://xstate.js.org), it is clear that thinking about web applications in terms of state machines is occurring much more frequently. With all this focus on state, transitions, and the benefits that come with structuring our applications like this, I've found there is still an area that is often overlooked when it comes to managing state in web applications: **the visual or presentation layer**.

CSS is incredibly powerful yet frequently misunderstood by most developers, which often leads to derision of the language. I think this is mostly due to a fundamental error in the way web developers manage presentation, often focusing their efforts on conditional logic in templates instead of a more flexible application of state-specific CSS selectors to HTML elements.

<iframe src="https://www.youtube.com/embed/xpnmtkjCNng?wmode=transparent" allowfullscreen frameborder="0" height="417" width="515"></iframe>

## A Simple Example

Let us examine a simple example of a multi-selectable list for a user interface (UI) that a designer may have provided in mockup form for us as web developers to decompose into working code.

![An animation of a multi-selectable list of users in tabular form. Each row has an icon which changes to indicate the selection state, defaulting to a snowman, empty checkbox on hover, and finally checked checkbox when selected.](/img/css-the-visual-state-machine/css-mockup.gif)

We can see there are a number of interactions at play, and at first glance these might seem simple enough that we would be tempted to solve the problem without putting much upfront thought into it. However, I think despite the simplicity of the example, there are enough complex states to enumerate that we should spend some time thinking about them before we dive into creating this UI.

| State                            | Trigger             | Change                                                                                                 |
| -------------------------------- | ------------------- | ------------------------------------------------------------------------------------------------------ |
| _Selected_                       | Click               | Icon changes to a checkbox                                                                             |
| _Unselected_                     | Click               | Icon changes to an empty box                                                                           |
| _Hovering, No Selections_        | Hover               | The snowman icon for the hovered row changes to an empty checkbox to indicate potential for selection  |
| _Hovering, 1 or More Selections_ | Hover               | All unselected row icons remain as empty checkboxes, and a yellow highlight appears on the hovered row |
| _1 or more Selections Active_    | No User Interaction | All icons change to empty checkboxes to indicate the ability to select multiple rows                   |

Putting aside [interaction design](https://en.wikipedia.org/wiki/Interaction_design) (IxD) and [accessibility](https://en.wikipedia.org/wiki/Web_accessibility) (a11y) concerns for the time being, after enumerating the states that we see here there is a lot to consider when building this UI! How should we manage the states? Should the logic live in our template or in our stylesheets? Let's take a brief look at the first approach, using an implementation in [Svelte](https://svelte.dev).

Svelte is a compiler that takes as input one or more `.svelte` files with _regions_ of functionality based on JavaScript, HTML, and CSS; with that input it produces the minimal amount of DOM API output in JavaScript to achieve the desired result. It's a different take than something like React, Angular, or Ember, which ship substantial runtimes to the browser that execute application code. If you are interested in learning more I highly recommend watching this excellent talk called _[Rethinking Reactivity](https://www.youtube.com/watch?v=AdNJ3fydeao)_ from Rich Harris introducing some of the core ideas. The code in the following examples is intended to be simple enough that you should be able to port the ideas represented to any other framework with minimal effort.

## Implementation: Templates

One of the first places a web developer might start is by crafting the template that represents the UI mockup we received from our designer friend above. This seems like a logical place to start, given we need some way to represent the data in a web browser. Let's build a template using svelte-infused HTML and see how it looks.

```xml
<table>
  {#each users as user}
  <tr>
    <td class="icon">
      {#if user.selected && hasSelection}
        {checkedBox}
      {:else if !user.selected && hasSelection}
        {uncheckedBox}
      {:else}
        {snowman}
      {/if}
    </td>
    <td>
      {user.name}
    </td>
    <td>
      {user.email}
    </td>
  </tr>
  {/each}
</table>
```

> Aside from the svelte-specific things like the `{#each}` and `{#if}` blocks, this is probably close to what you might implement in any front-end or server-side templating solution.

We've taken the list of potential states that we extracted from the mockup above and encoded them as conditional logic in our templates in order to achieve the desired result. The one special case we needed to account for was the non-interactive state "1 or more Selections Active"; to do this we defined a local variable in our JavaScript region called `hasSelection` which is defined using Sveltes [reactive declarations](https://svelte.dev/tutorial/reactive-declarations) as

```javascript
$: hasSelection = users.some(u => u.selected)
````

Although the code above satisfies _most_ of the user experience (UX) as detailed in the mockup, there are two problems that shake out of an implementation like this that focuses on conditional logic in templates:

1. We didn't capture _all_ of the states enumerated, as we cannot effectively translate a user's `hover` action in templates alone unless we get really creative and complex
2. This paradigm scales _very poorly_ as our templates grow, mixing concerns of `presentation` and `data` in a template, resulting in code that is much harder to read and maintain over the life of a project

The scalability concern is the more worrisome of the two, yet is a common byproduct of developers using conditional logic in templates. Increasingly thorny conditionals can lead to missed acceptance criteria, which in turn can lead to stress and tension on a team. Rather than throw blame around, it's worth focusing on whether that approach is healthy for a long-term project.

I think we can do better if we shift our focus from conditional logic in templates to thinking more in terms of leveraging CSS as the language we use to define the states in our presentational state machine and using JavaScript to manage when to apply those states. Let's see what that looks like as we refactor the above example.

## Implementation: Stylesheets

One of the first considerations we'll need to make is how to address both the concerns raised in the previous section. We need to handle the `hover` state properly, and we also should strive for a solution that encodes data in the template and presentation in the stylesheets. Let's start by refactoring the template to eliminate the conditional logic:

```xml
<table class:hasSelection="{hasSelection}" class="selectable">
  {#each users as user}
  <tr class:selected="{user.selected}">
    <td class="icon"></td>
    <td>
      {user.name}
    </td>
    <td>
      {user.email}
    </td>
  </tr>
  {/each}
</table>
```

The first thing you might notice is that we removed the conditional blocks replaced them with [svelte's class element directive](https://svelte.dev/docs#class_name). This is an elegant way to control toggling of a CSS class on an element via a boolean value, which we previously defined as `{user.selected}` and `{hasSelection}`. We also added a `class=selectable` to the root table element in order to allow us to better manage the complexity of the conditional logic for states in CSS. Let's defer looking at the JavaScript that defines those values and instead look at what the definition of each state in our presentational state machine looks like when we encode it with CSS:

``` css
/*
  CSS variables in conjunction with escaped unicode or html
  entities are a great way to represent things like icons
*/
:root {
  --unchecked-box: "\02610";
  --checked-box: "\02611";
  --snowman: "\02603";
}

/*
  Managing the hover states to show a yellow background
*/
tr:hover,
tr:hover td {
  cursor: pointer;
  background-color: yellow;
}

/*
  Our first state, every icon should default to the snowman
*/
.icon:after {
  content: var(--snowman);
}

/*
  A complex state, if the table has a selection,
  then every selected items icon should be the checked box
*/
.selectable.hasSelection .selected .icon:after {
  content: var(--checked-box);
}

/*
  A combined selector to handle the alternative complex states:
  - for a table without a selection, when the user hovers, show the unchecked box
  - for a table with selections, swap the icon from the snowman to the unchecked box
*/
.selectable:not(.hasSelection) tr:hover .icon:after,
.selectable.hasSelection .icon:after {
  content: var(--unchecked-box);
}
```

With the combination of CSS and svelte-infused HTML we've achieved the result our designer was hoping for when they handed us the initial mockup, with an appropriate separation between the definition of our states (CSS) and the application of those states (HTML, and JavaScript).

For completeness, here is the entirety of the example as included in `Application.svelte` from the [code on github](https://github.com/davemo/svelte-casts):

```xml
<script>
  let users = [
    {name: 'Danika Dywtgowm', email: 'danika.dywtgowm@email.com'},
    {name: 'Erica Bule', email: 'erica.bule@email.com'},
    {name: 'Jim Snales', email: 'jim.snales@email.com'},
    {name: 'Daria Thorobox', email: 'daria.thorobox@email.com'},
    {name: 'Mendikant Hargrove', email: 'mendikant.hargrove@email.com'},
    {name: 'Ephraim Lischok', email: 'ephraim.lischok@email.com'},
    {name: 'Lera Nedialkova', email: 'lera.nedialkova@email.com'},
  ]

  function selectUser(user) {
    users[users.findIndex(u => u.name === user.name)] = {
      ...user,
      selected: !user.selected
    }
    console.log(`${user.name} was ${user.selected ? 'de-selected' : 'selected'}`);
  }

  $: hasSelection = users.some(u => u.selected)
</script>

<style>
  :root {
    --unchecked-box: '\02610';
    --checked-box: '\02611';
    --snowman: '\02603';
  }

  td {
    padding: 5px;
  }

  tr:hover, tr:hover td {
    cursor: pointer;
    background-color: yellow;
  }

  .icon, .template-icon {
    display: flex;
    justify-content: center;
  }

  .icon:after {
    content: var(--snowman);
  }

  .selectable.hasSelection .selected .icon:after {
    content: var(--checked-box);
  }

  .selectable:not(.hasSelection) tr:hover .icon:after,
  .selectable.hasSelection .icon:after {
    content: var(--unchecked-box);
  }
</style>

<h1>Complex Multi-Select</h1>

<table cellspacing=0 class:hasSelection={hasSelection} class=selectable>
  {#each users as user}
  <tr class:selected={user.selected} on:click={() => selectUser(user)}>
    <td class=icon height=20 width=20></td>
    <td>
      {user.name}
    </td>
    <td>
      {user.email}
    </td>
  </tr>
  {/each}
</table>
```

## Closing Thoughts

This is how I have tended to manage the working relationship between HTML and CSS for the last 20 years, and I think the power of thinking in this way leads to cleaner code and easier to refactor web interfaces.

If this looks completely foreign to you and you found yourself considering that the template-based conditional-logic approach made more sense, I'd recommend learning more about the capabilities of CSS features like [pseudo-selectors :not](https://developer.mozilla.org/en-US/docs/Web/CSS/var), [variables](https://developer.mozilla.org/en-US/docs/Web/CSS/var), and the [generated content: property](https://developer.mozilla.org/en-US/docs/Web/CSS/content).

I've found that teams who up their level of knowledge in CSS and tend to try to split concerns like we've done here will have web applications that are easier to change over the long term.

If you are interested in learning more about this approach and seeing a live coded version of this blog post, please check out the [screencast](https://www.youtube.com/watch?v=xpnmtkjCNng) posted to my YouTube channel; it walks through all the examples and touches on a few more svelte-specific things to consider.

## Learning Resources

- [Svelte Tutorial](https://svelte.dev/tutorial/basics)
- [Complex-Multi-Select Code on Github](https://github.com/davemo/svelte-casts)
- [CSS Variables](https://developer.mozilla.org/en-US/docs/Web/CSS/var)
- [CSS :not pseudo-selector](https://developer.mozilla.org/en-US/docs/Web/CSS/:not)
- [CSS Generated Content](https://developer.mozilla.org/en-US/docs/Web/CSS/content)
- [HTML Entity Symbols](https://www.toptal.com/designers/htmlarrows/symbols/)