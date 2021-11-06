We covered a lot of ground on the [MyFrontSteps](https://www.myfrontsteps.com)
project this week. We managed to migrate our Photo Management / Uploading
solution on Homebook from [SWFUpload](https://swfupload.org/) and a lot of hacked
together [jQuery](https://www.jquery.com) to a more elegant solution (albeit one
that could still use some refactoring - but what code can't use refactoring
really). We decided to use the "still-in-beta" [YUI
Uploader](https://developer.yahoo.com/yui/uploader/) coupled with some custom
jQuery. The implementation seems much more cohesive than our previous solution
but there were a few gotchas we rant into when trying to get things working
properly in IE7.

### YUI Uploader

I know this component is still in beta support from Yahoo, but I had given it a
very brief try in our supported browser baseline (currently FF2+, Safari3+,
IE7+) and it seemed to work really well. All of the YUI stuff we're using works
really well and the graded browser support and testing the YUI team puts behind
their work makes implementation that much more reliable. That being said, no
piece of software is perfect and we ran into a pretty frustrating bug
implementing the YUI Uploader in a specific area of the application.

 ![A flyover context menu with an embedded YUI
Uploader.](https://davemo.wordpress.com/files/2009/03/picture-24.png "Flyover Context Menu")

We have a number of context menus in Homebook that appear to the user on
mouseover. This particular thumbnail represents the default image for a users
Home, and clicking it prompts the user with a file dialog to select a new photo
which is then uploaded via the YUI Uploader. When instantiated, the uploader
inserts a transparent Flash object using the
[SWFObject](https://blog.deconcept.com/swfobject/) plugin into the markup in the
container specified. In our case we had the following markup:

>     ul class='mfs-context-menu invisible' id='default-image-menu'
>             li
>                a
>                  span class='uploader' id='upload-profile-picture' /span
>                  'Change Profile Picture'
>               /a
>            /li
>         /ul

We use a class of invisible to set the css property 'display:none;' on the 'ul'
so it's hidden by default when the page loads. When the page loads and the
script triggers, the uploader sits nicely in the span tag directly above the
link in the li tag. The user then clicks on the transparent flash object and the
upload can start. Now, this approach works fine in every browser EXCEPT IE7. For
some reason when the uploader is instantiated in IE7 if it becomes hidden and
then shown again at any point the YUI Uploader loses all binding to the
functions that trigger submission to the server side url. I tried doing some
searching to see if this was documented anywhere and came up empty everywhere I
looked.

My best guess is that the IE7 security model doesn't like the fact that an
'embed' tag with the Flash object is being manipulated from JavaScript and
decided to turn off something that disables the uploader from completing an
upload. The file dialog will still popup, and the embedded Flash remains in the
DOM but the uploader doesn't trigger sending of the files to the server. It took
us a while to figure out what was going on, and the only way we tracked it down
was by a process of elimination commenting out lines of code in the uploader
instantiation script until we discovered it was our context menu show/hide
trigger that made the uploader behave this way. So, the solution in our case was
to move the uploader 'span' tag outside of the 'li' but still inside the
thumbnail container, give it a fixed width and height directly above the image
(like a transparent rectangle) and bind mouseover/mouseout events to it that
triggered show/hide of the 'li' element with the 'a' inside:

>     ul class='mfs-context-menu invisible' id='default-image-menu'
>             span class='uploader' id='upload-profile-picture' /span
>             li a 'Change Profile Picture' /a /li
>         /ul

This way the flash element never gets hidden, and IE7 doesn't do anything funky
to it so the uploader remains operational.

