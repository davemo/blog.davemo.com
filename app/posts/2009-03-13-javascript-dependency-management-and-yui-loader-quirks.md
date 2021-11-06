[Brett](https://bzabos.wordpress.com/) and I recently began refactoring a
significant amount of the JavaScript that is currently in
[MyFrontSteps](https://www.myfrontsteps.com) and
[Homebook](https://www.myfrontsteps.com/myfrontsteps/home/). One of the areas we
identified as needing improvement was controlling when scripts get loaded in the
page; it's a challenging subject especially when utilizing Django templates
which can extend and include bits of HTML that are both static and dynamic.
We're not finished the refactoring quite yet but I thought it would be valuable
to blog about the lessons we've learned early on about how to manage JavaScript
loading without having script tags all over the place.

### Manual Dependency Management is Hard

Not too long ago, Yahoo put out a list of
[guidelines](https://developer.yahoo.com/performance/rules.html) that web
developers can use to enhance the performance of their websites. I won't get
into it in this post but there is a Firefox plugin called
[YSlow](https://developer.yahoo.com/yslow/) available that can automate some of
the performance checking. The recommendation I'm going to focus on here is the
one regarding moving scripts as close to the bottom of the page as possible.
I'll just quote the [Yahoo
doc](https://developer.yahoo.com/performance/rules.html) as they explain it very
clearly:

> The problem caused by scripts is that they block parallel downloads. The
> [HTTP/1.1
> specification](https://www.w3.org/Protocols/rfc2616/rfc2616-sec8.html#sec8.1.4)
> suggests that browsers download no more than two components in parallel per
> hostname. If you serve your images from multiple hostnames, you can get more
> than two downloads to occur in parallel. While a script is downloading,
> however, the browser won't start any other downloads, even on different
> hostnames. In some situations it's not easy to move scripts to the bottom. If,
> for example, the script uses `document.write`to insert part of the page's
> content, it can't be moved lower in the page. There might also be scoping
> issues. In many cases, there are ways to workaround these situations.

In the case of the code we're using on MyFrontSteps we had all kinds of Django
templates with includes and templatetags that include other little bits of
dynamic JavaScript that was adding markup to the DOM and manipulating DOM
content. Some of this code would appear prior to certain dependent scripts being
loaded which created a real nightmare for us as we had to manually track down
the position of the dependent scripts in the page that was fed to the browser
after a variable number of layers of templates and includes. We decided to
research a better way to manage all these scripts and since we had been using
the YUI library for many other parts of the website we settled on the [YUI
loader](https://developer.yahoo.com/yui/yuiloader/).

### YUI Loader Makes Dependency Management Easy

> The YUI Loader Utility is a client-side JavaScript component that allows you
> to load specific YUI components and their dependencies into your page via
> script. YUI Loader can operate as a holistic solution by loading all of your
> necessary YUI components, or it can be used to add one or more components to a
> page on which some YUI content already exists.

The great thing about the YUI Loader is that you can use it to manage dependency
sorting for all of the YUI components you use on a page but the *killer* feature
imho is the fact that it allows you to create custom modules to load your own JS
and CSS libraries. The basic pattern we're using in our root level Django
template is as follows:

1.  Load all CSS Files at the top of the template
2.  Place all YUI Loader and other statically included scripts at the bottom of
    the page prior to the closing BODY tag
3.  Define the YUI Loader instance
4.  Define custom modules for the YUI loader
5.  Provide a Django template block to allow manipulation of the onSuccess
    callback
6.  Call the YUI Loaders .insert() method to trigger insertion of all dependency
    sorted scripts into the DOM

The advantage to using the loader in conjunction with our root Django template
is clear; all of our scripts are loaded at the bottom of the page and CSS is
loaded at the top. When a user requests the pages they will start receiving the
content from the server immediately and not have to wait for scripts to process
as the loader dynamically inserts them into the HEAD element after the page
content has been rendered. Another trick we're using to control when scripts get
executed is by manipulating how the onSuccess callback of the loader works.
Here's the code:

>     // Instantiate and configure YUI Loader:
>     MFSLoader = new YAHOO.util.YUILoader({
>         base: "",
>         require: ["base","reset-fonts-grids","MFS"],
>         loadOptional: false,
>         combine: true,
>         filter: "MIN",
>         allowRollup: true,
>         onSuccess: function() {
>             while( MFSLoader.onReady.length )  {
>                 MFSLoader.onReady.shift()();
>             }
>         }
>     });
>
>     // Define a list of executables that we
>     // can add to prior to page load completion
>     MFSLoader.onReady = [];
>
>     // Custom Modules for Loader
>     MFSLoader.addModule({
>         name: 'MFS', type: 'js', varName: 'MFS',
>         path: '{% vurl "/static/script/MFS.js" %}',
>         requires: ['jQuery', 'jQueryUI']
>     });
>
>     {# Override this block if you need script at the global level. #}
>     {% block global.script %}{% endblock %}
>     // Trigger insertion of all dependency sorted scripts into the DOM
>     MFSLoader.insert();

As you can see we have a few of the custom modules defined here, which include a
'requires' attribute in the configuration object. This lets the YUI Loader know
that these files require the other modules to be loaded. The Loader then
determines sort order for inclusion based on all required modules and goes to
work inserting the scripts for you.

### Tying it all Together

The key to making this work in the varying levels of Django templates is to
manipulate the onSuccess callback. When the YUI Loader finishes loading all the
dependency sorted scripts it will execute this callback and allow you to then
execute any additional code that depends on the dynamically inserted scripts. We
have a number of namespaced JS objects for MyFrontSteps (MFS.js, MFS.DataGrid.js
etc..) and when we need to call functions defined in these objects we do so by
extending the global.script block in our child template and pushing a new
anonymous function onto the MFSLoader.onReady list we defined in the root
template. Here's a simple example:

>     {# A CHILD TEMPLATE #}
>     {% block global.script %}
>         #include the parent templates global.script contents
>         {{ block.super }}
>
>         // Load our required features
>         MFSLoader.require( 'MFS.DataGrid', 'uploader', 'MFS.Uploader' );
>         // Push an anonymous function onto the list
>         // to get executed when all required scripts have been loaded
>         MFSLoader.onReady.push( function()  {
>             MFS.DataGrid.initPhotosGrid();
>         });
>     {% endblock %}

Once the page is rendered and the YUI Loader has finished parsing the loaded
scripts the code we have in the onSuccess callback pops all the anonymous
functions off the list which causes them to be executed.

>     {# THE ONSUCCESS CALLBACK #}
>     onSuccess: function() {
>         while( MFSLoader.onReady.length )  {
>             MFSLoader.onReady.shift()();
>         }
>     }

We still have a number of files to refactor, but the performance benefits we've
seen so far using this approach have really made us confident that this is the
way to go. Using a dependency manager that works for custom JS / CSS libraries
is just so much more liberating than having to manually keep track of where
scripts are getting executed. Because we're also migrating all of our code to
external library files it makes things that much easier to debug in Firebug as
well. :)
