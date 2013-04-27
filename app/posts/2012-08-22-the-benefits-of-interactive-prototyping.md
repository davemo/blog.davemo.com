# david mosher

## This is an archived post This is an archived post

[Previous](../../../posts/2012/09/understanding-view-zombie-events-in-backbonej.html)
  [Index](../../../index.html)  
[Next](../../../posts/2012/04/sunday-blues-jam.html)

### The Benefits of Interactive Prototyping

August 22 2012, 7:53 PM  by David Mosher

I had a small epiphany today while working on a new prototype for a client:
"different stages of prototyping yield different levels of information". I know
I know, not much of a brainwave there, right? I was never one for writing
headlines and there's a lot of knowledge packed into that statement, so stick
with me as I attempt to unpack it for you :)

## The Gist

Those familiar with it will know there are some basic ways to prototype that
progress upwards in terms of fidelity. At the lowest end of the fidelity
spectrum people often start by drawing lots of boxes and arrows on paper. Next
comes some of the static mockup tools that are popular today, like
[Balsamiq](http://www.balsamiq.com/), [Hot Gloo](http://www.hotgloo.com/),
[Fireworks](http://www.adobe.com/products/fireworks.html) (and many more).
Further up the fidelity chain comes prototyping in the Browser which has some
interesting advantages over static prototypes; what struck me today was how much
more I could learn from prototyping in the browser when I moved from static
markup into interactivity. Each level of fidelity provides different things we
can learn; at a high level this is how I think it breaks down:

-   Paper Prototyping
    -   What I think the information architecture hierarchy should be.

-   Static Prototyping
    -   How I think the information architecture hierarchy will flow from one
        area to another.

-   Browser Prototyping (Static)
    -   How the information hierarchy actually flows from one area to another at
        different screen resolutions.
    -   How changes in typography, size, and placement affect the usability of
        my information architecture.

-   Browser Prototyping (Interactive)
    -   How robust the information architecture and design are when considering
        user interaction.
    -   What things I should do first to improve my information architecture and
        design.

As I read through the list above I notice a few interesting things. Firstly, the
value of the information I receive increases as I move to a higher fidelity
prototype. In Paper and Static prototyping the information I get isn't really
all that useful; for the most part it is hypothetical. I can show it to others
to get more feedback but it is still subjective; based on perception and varied
interpretation. It isn't until I move into prototyping with the Browser that I
can actually play with the information, architecture, and layout and start to
get concrete information that will help me approach what I need to change in my
next iteration.

## In Practice

The interface and interaction I have been prototyping the last two days is for a
user creating a fitness challenge comprised of multiple activities for multiple
participants. As I was working to take my browser prototype from static to
interactive I discovered that even though I had a good idea of how the system I
was implementing worked I found I didn't have a great way to express the system
thinking in a user interface that made sense to humans.

So often engineers have a great grasp on what the system requirements are for
the interface they are building that they end up building the interface as if it
reads like machine language. In the last two days I feel it was very valuable to
repeatedly try to express the system constraints in "plain old english" as if I
were a user trying to interact with them, but I didn't come to that realization
until I made the leap from static to interactive.

* * * * *

![Static Prototype
1](http://f.cl.ly/items/3D1t0k1K073g2o3h3L3a/static.prototype.1.png)

In my first pass at the prototype with static content and no interaction this is
what I came up with. The interaction theory was that users would fill in basic
details about the fitness challenge and be able to see a preview summary of what
the challenge would look like before submitting to the server(you can see the
summary at the bottom of the screen). During this iteration I came to the
realization that that positioning the summary at the bottom of the screen does
nothing to help users understand what it is they are doing; we ended up deciding
on a new layout that positions the summary to be always in the users view in the
following iteration.

* * * * *

![Static Prototype
2](http://f.cl.ly/items/1W1T340A0W0V3c2T1Y2f/static.prototype.2.png)

In this iteration the idea for a "live updating" summary was the driver for the
layout change. We thought that if users could see the results of their
interaction taking shape live it would help to reinforce how the interface was
affecting the output (challenge creation).

* * * * *

![iOS Static Prototype
1](http://f.cl.ly/items/0E41451o0B1f1V1J2w2W/iOS.prototype.1.png)

![iOS Static Prototype
2](http://f.cl.ly/items/1F3r351R0G2Q1D3Q3p0E/iOS.prototype.2.png)

![iOS Static Prototype
3](http://f.cl.ly/items/2a0C3T3b1q1m293m0g1y/iOS.prototype.3.png)

Because one of our design constraints was to attempt to make this page work for
both desktop and mobile we implemented the [twitter bootstrap responsive
stylesheet](http://twitter.github.com/bootstrap/scaffolding.html#responsive) so
we could play with the layout and see how it felt. This is one of the biggest
benefits of designing in a browser first and previewing the design in the iOS
simulator really helped to further shape the layout. Up to this point we were
still iterating with static markup and felt like we were making good progress
with the information we had received from in browser testing. The next step was
to start wiring up user interactions to see what else was revealed.

* * * * *

![Dynamic Prototype
1](http://f.cl.ly/items/0V4742133R030g453t1D/dynamic.prototype.1.png)

I've been using [Backbone.JS](http://documentcloud.github.com/backbone/) for the
last 18 months and it's a wonderful tool for building prototypes with. We
decided to add some simple collection backed views and flesh out the user
interaction of adding Activities and having them update live in the preview.
What this yielded first was a realization that our design didn't account for all
that many rules due to our fixed position summary preview. (note: the new [affix
plugin](http://twitter.github.com/bootstrap/javascript.html#affix) in [bootstrap
2.1](http://twitter.github.com/bootstrap/) is \_great\_ for this, but you should
be aware of how tall your content could potentially be!)

* * * * *

![Dynamic Prototype
2](http://f.cl.ly/items/2T2h3a1y232u2a1a3619/dynamic.prototype.2.png)

Oops. You could say I should have encountered that in the static stage of in
browser testing by adding more static data to test the layout, but I didn't and
I find that this is often the case with static prototypes. Adding interactivity
to a prototype helps to uncover places your design breaks down. It was at this
point I had a discussion with a teammate to demo what had been built so far and
we both came to the realization that the tabular display under the activities UI
was not user friendly. The interface for adding Activities seems to read like
english (we arrived at that after a number of iterations) but the display of the
data isn't helpful to users at all and really mirrors how the underlying system
stores the data.

* * * * *

## Moving Forward

Our next step will be to prototype a layout where the summary preview \_is\_ the
interface to eliminate the "system language" from the interface altogether. In
conclusion, I don't think we would have been able to iterate and refine our
approach as effectively if we had not started in the browser and added
interactivity to the prototype soon after prototyping with static markup. The
things we can learn from interactive prototypes can really help crank out
interfaces that are much more usable.

If you aren't already prototyping interactivity in the browser I would encourage
you to start as soon as possible, the earlier you start the earlier you'll find
out how to fix your interface! :)

#### Tags

backbone, bootstrap, ixd, prototyping, ux

#### 515 views and 0 responses

