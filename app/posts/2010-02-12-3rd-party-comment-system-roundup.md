---
title: "Third-Party Comment System Roundup"
date: "2010-02-12"
description: "A review of third-party commenting systems for use with blogs."
---

<aside class="tldr">
Commenting systems on the web are a subject of "intense debate" (pun intended).
</aside>

We've all seen it. The classic tutorial on **[insert popular web framework here]** that has us building a blogging system in twenty minutes or less. It's actually getting kind of old and I'm growing sick of seeing what I'm able to create with only platform x,y and z. I'm more interested in how I can use a web framework that doesn't hold my hand by providing a bunch of "one size fits all" defaults. I like flexibility and choice.

I like it when the web framework I'm using allows me to mix and match third party systems easily. One third party web framework component that is becoming more popular is commenting systems. Let's take a brief look at three of the most popular systems to see what each offers us.

## Intense Debate

![Intense Debate Logo](/img/comment-roundup/intense-debate-logo.png)

[www.intensedebate.com](https://www.intensedebate.com)

[@photomatt](https://twitter.com/photomatt)

I first experienced using intense debate when reading a couple blog posts on John W. Longs [wise heart design](https://www.wiseheartdesign.com). Created by [automattic](https://twitter.com/automattic) of wordpress fame, Intense Debate (ID) is a hosted commenting system that utilizes some sexy javascript and social network integration to allow you to add comments to pretty much any page on the Internet. My experience with the sign up process for intense debate was actually pretty frustrating as the log in system didn't seem to recognize my OpenID and you can't create an account for the purposes of installation with anything except OpenID or their hand rolled registration.

I was expecting to be able to sign up using any of the social networks they allow you to sign into their commenting system with. Room for improvement for sure but at least it doesn't affect the actual commenting sign system sign in.

On the plus side, once you do get an account created setup is pretty painless and involves pasting some simple javascript into the page that you want to add comments to.

### Sample Code

1. Copy and paste the following code into the area where you would like Intense Debate comments to appear:

```xml
<script>
var idcomments_acct = '0cd704f243eb86ac2349b051d5acc0e9';
var idcomments_post_id;
var idcomments_post_url;
</script>
<span id="IDCommentsPostTitle" style="display:none;"></span>
<script src='http://www.intensedebate.com/js/genericCommentWrapperV2.js'></script>
````

2. To display a link with the current comment count, for example `Comments (7)`, copy and paste the following code where you want the link to appear:

```xml
<script>
var idcomments_acct = '0cd704f243eb86ac2349b051d5acc0e9';
var idcomments_post_id;
var idcomments_post_url;
</script>
<script src='http://www.intensedebate.com/js/genericLinkWrapperV2.js'></script>
```

How about the user experience when commenting on a site? This is where I really appreciate the power of third party commenting systems, with the value added by extra features I didn't have to code. Things like email notifications when someone replies to a thread, sign in using any of the social networks I'm a part of (ID supports Facebook, Twitter, and Open ID at the time of writing), automated threading, profile linking, upvote/downvote, comment history, and integration with popular blogging platforms like wordpress, blogger (hint hint Posterous, it would be nice if you added this!).

I was also pleasantly surprised that a [tweet](https://twitter.com/dmosher/status/8168838760) about a bug in the email notification system yielded a really fast response from their technical support team. Did I mention it's free?

## JS-Kit Echo

![The JS-Kit Echo Logo](/img/comment-roundup/echo-logo.png)

[www.js-kit.com](https://www.js-kit.com)

[@echoenabled](https://twitter.com/echoenabled)

I haven't used JS-Kit (JSK) on any live blogs but my good buddy [Nathan Heagy](https://www.twitter.com/nheagy) let me know of it's existence a few months ago and I was intrigued to see what it might offer. Some differences from other systems is that JSK allows you to publish comments from a larger variety of places and broadcast those comments out to more than just the web page the comment thread is embedded on (ie: google friend, yahoo friends and FriendFeed in addition to the regular social networks). JS-Kit also has image uploading, YouTube video embedding, a basic comment formatting interface and lots more. These features are nice, but I don't think they add as much value and here's the kicker: JS-Kit isn't free. They have a 30 day free trial available but after that [pricing](https://js-kit.com/pricing/) starts at \$12/year but is based on the amount of traffic your site gets.

The code seems easy enough to understand:

### Sample Code

The JavaScript needs to be pasted in the page where you want to run Echo.

```xml
<div class="js-kit-comments" permalink=""></div>
<script src="http://js-kit.com/for/mysite.com/comments.js"></script>
```

JS-Kit is ok but Intense Debate being free and providing essentially the same core features without all the "bells and whistles" appeals to me much more. **YMMV**.

## Disqus

![](/img/comment-roundup/disqus-logo.png)

[www.disqus.com](https://www.disqus.com)

[@disqus](https://twitter.com/disqus)

The veteran in hosted commenting systems, Disqus has been around for a lot longer than either Intense Debate or JS-Kit and it shows. Disqus offers the most in terms of supported platforms for connecting to and rebroadcasting to as well as the media features that JSK offers (video and image publishing). Setup is slightly more involved; if you want to add things like Facebook Connect and Akismet (for spam protection) you need to provide API keys. Again the code is very easy to inject into any page, static or dynamic.

### Sample Code

```xml
<script src="http://disqus.com/forums/[yourid]/combination_widget.js?num_items=5&hie_mods=0&color=blue&default_tab=people&exerpt_length=200"></script>
<a href="http://disqus.com/">Powere by Disqus</a>
```

Disqus also gives you the power to control the look and feel of the commenting interface right inside their control panel. This is a pretty nice feature for people who aren't so technical that they want to hack away at the CSS manually. The fact that right out of the gate Disqus is free and offers just as much power as JS-Kit and Intense Debate makes it a pretty attractive option.

## Conclusion

These are just a few of the options out there if you want to implement a
commenting system and don't want to write it yourself. I hope you learned
something reading this (I sure did writing it). I made sure to research all the
facts as best I could before writing but in case I missed anything please feel
free to let me know in the .... commenting system Posterous has built in :]
