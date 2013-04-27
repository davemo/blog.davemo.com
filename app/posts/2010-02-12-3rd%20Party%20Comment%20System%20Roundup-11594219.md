# david mosher

## This is an archived post This is an archived post

[Previous](../../../posts/2010/02/Wrapping%20up%20sprint%20planning%20on%20the%20@steprep%20team.%20Now%20with%20more%20taskboard%20lanes!%20%23scrum%20%23agile%20-11801345.html)
  [Index](../../../index-2.html)  
[Next](../../../posts/2010/02/A%20mini%20low%20res%20blast%20from%20the%20past-11555059.html)

### 3rd Party Comment System Roundup

February 12 2010, 1:58 PM  by David Mosher

We've all seen it. The classic tutorial on [insert popular web framework here]
that has us building a blogging system in twenty minutes or less. It's actually
getting kind of old and I'm growing sick of seeing what I'm able to create with
only platform x,y and z. I'm more interested in how I can use a web framework
that doesn't hold my hand by providing a bunch of "one size fits all" defaults.
I like flexibility and choice. I like it when the web framework I'm using allows
me to mix and match third party systems easily. One third party web framework
component that is becoming more popular is commenting systems. Let's take a
brief look at three of the most popular systems to see what each offers us.

### Intense Debate

****

![](../../../image/2010/02/6538176-media_httpfarm3static_zwrDw.png)

[www.intensedebate.com](http://www.intensedebate.com)

[@photomatt](http://twitter.com/photomatt)

I first experienced using intense debate when reading a couple blog posts on
John W. Longs [wise heart design](http://www.wiseheartdesign.com). Created by
[automattic](http://twitter.com/automattic) of wordpress fame, Intense Debate
(ID) is a hosted commenting system that utilizes some sexy javascript and social
network integration to allow you to add comments to pretty much any page on the
Internet. My experience with the sign up process for intense debate was actually
pretty frustrating as the log in system didn't seem to recognize my OpenID and
you can't create an account for the purposes of installation with anything
except OpenID or their hand rolled registration.

I was expecting to be able to sign up using any of the social networks they
allow you to sign into their commenting system with. Room for improvement for
sure but at least it doesn't affect the actual commenting sign system sign in.
On the plus side, once you do get an account created setup is pretty painless
and involves pasting some simple javascript into the page that you want to add
comments to.

#### Sample Code

![](../../../image/2010/02/6538431-media_httpfarm5static_keJjk.png)

![](../../../image/2010/02/6538432-media_httpfarm3static_EDxfH.png)

How about the user experience when commenting on a site? This is where I really
appreciate the power of third party commenting systems, with the value added by
extra features I didn't have to code. Things like email notifications when
someone replies to a thread, sign in using any of the social networks I'm a part
of (ID supports Facebook, Twitter, and Open ID at the time of writing),
automated threading, profile linking, upvote/downvote, comment history, and
integration with popular blogging platforms like wordpress, blogger (hint hint
Posterous, it would be nice if you added this!). 

I was also pleasantly surprised that a
[tweet](http://twitter.com/dmosher/status/8168838760) about a bug in the email
notification system yielded a really fast response from their technical support
team. Did I mention it's free?

### JS-Kit Echo

****

![](../../../image/2010/02/6538178-media_httpfarm3static_rBiqF.png)

[www.js-kit.com](http://www.js-kit.com)

[@echoenabled](http://twitter.com/echoenabled)

I haven't used JS-Kit (JSK) on any live blogs but my good buddy [Nathan
Heagy](http://www.twitter.com/nheagy) let me know of it's existence a few months
ago and I was intrigued to see what it might offer. Some differences from other
systems is that JSK allows you to publish comments from a larger variety of
places and broadcast those comments out to more than just the web page the
comment thread is embedded on (ie: google friend, yahoo friends and FriendFeed
in addition to the regular social networks). JS-Kit also has image uploading,
YouTube video embedding, a basic comment formatting interface and lots more.
These features are nice, but I don't think they add as much value and here's the
kicker: JS-Kit isn't free. They have a 30 day free trial available but after
that [pricing](http://js-kit.com/pricing/) starts at \$12/year but is based on
the amount of traffic your site gets.

The code seems easy enough to understand:

#### Sample Code

![](../../../image/2010/02/6538433-media_httpfarm5static_huuwm.png)

JS-Kit is ok but Intense Debate being free and providing essentially the same
core features without all the "bells and whistles" appeals to me much more. YMMV
;)

### Disqus

****

****

![](../../../image/2010/02/6538177-media_httpfarm3static_vHgyp.png)

[www.disqus.com](http://www.disqus.com)

[@disqus](http://twitter.com/disqus)

The veteran in hosted commenting systems, Disqus has been around for a lot
longer than either Intense Debate or JS-Kit and it shows. Disqus offers the most
in terms of supported platforms for connecting to and rebroadcasting to as well
as the media features that JSK offers (video and image publishing). Setup is
slightly more involved; if you want to add things like Facebook Connect and
Akismet (for spam protection) you need to provide API keys. Again the code is
very easy to inject into any page, static or dynamic.

#### Sample Code

![](../../../image/2010/02/6538434-media_httpfarm5static_jiFnk.png)

Disqus also gives you the power to control the look and feel of the commenting
interface right inside their control panel. This is a pretty nice feature for
people who aren't so technical that they want to hack away at the CSS manually.
The fact that right out of the gate Disqus is free and offers just as much power
as JS-Kit and Intense Debate makes it a pretty attractive option.

### Conclusion

These are just a few of the options out there if you want to implement a
commenting system and don't want to write it yourself. I hope you learned
something reading this (I sure did writing it). I made sure to research all the
facts as best I could before writing but in case I missed anything please feel
free to let me know in the .... commenting system Posterous has built in :]

#### Tags

comment, framework, javascript, thirdparty, vendasta

#### 6805 views and 3 responses

-   Feb 20 2010, 1:31 PM

    Jani Hartikainen responded:

    My main concern with 3rd party systems like these is that they use
    JavaScript. I've occasionally had glitches with them on desktop browsers,
    and nowadays when I read more blogs on my phone (like right now), I'm
    worried the JS trickery may not always work very well on mobile browsers due
    to their differences.

    Much of their features are possible to include for example in WordPress via
    plugins (mail on reply etc.)

-   Feb 20 2010, 1:43 PM

    David Mosher responded:

    I definitely agree that for mobile devices it might not be the best to rely
    so heavily on javascript, however if you look at the newer mobile browsers
    coming out they seem to work fine with most of it.

    Your point about wordpress is true, but even they have support for some of
    these commenting systems with a plugin. I was mainly considering programmers
    who want to piece together a blog system and need to know what's available
    for 3rd party systems :)

    Thanks for your comments Jani :)

-   Jul 10 2010, 3:02 PM
    Car Games responded:
    I've been Googling all day and I still don't know which system is better for
    my site; Disqus or Echo? or even maybe Intense Debate.
