---
title: "Vibing Like It's 1999"
date: "2025-11-13"
description: "I thought my very first website from the late '90s was lost forever. Turns out, all I needed was a lucky break and an AI exploration partner to help me track it down and bring it back to life."
social_img: "/img/vibing-like-its-1999/social-card.png"
---

<aside class="tldr">LLMs make great "digital archivists," resurrecting old sites and finding lost assets via the Wayback Machine.</aside>

I've been down a nostalgia rabbit hole lately, trying to track down a lot of my early internet artifacts—including my first website.

I had been hunting in the various internet archives for *DM Designs™*, the first website I published in 1998, but for the life of me I couldn't remember the URL slug. I knew the [GeoCities](https://en.wikipedia.org/wiki/GeoCities) neighborhood was in Sunset Strip, but my searches in [many](https://blog.archive.org/2009/08/25/geocities-preserved/) of the [remaining](https://www.oocities.org/) [archives](https://geocities.restorativland.org/) always came up empty. Those archives are themselves admittedly only partial snapshots of what once was.

As luck would have it, while digging around in my basement, I stumbled across a DVD-RW I had burned around 2003. It was a backup of many of my early web projects, and stuffed in a folder was a partial copy of the GeoCities site.

The code was a typical late '90s mess: invalid HTML, broken images, the works. Pretty common for the time, given that a lot of it was built with the GeoCities WYSIWYG editor. This was my very first foray into web development. Finding the site was great, but getting it up and running again turned into a fun experiment that became its own side-quest exploring what features existed in web browsers at the time.

Reflecting on this almost 30 years later, I'm struck by how robust HTML, CSS, and JavaScript are. It's remarkable how well these languages and browsers have held up over time.

## The hunt for missing pieces

I started exploring whether some of the assets missing from my local archive could be recovered from the [Wayback Machine](https://web.archive.org/). There were a few hits for some of my other sites, but for this one a lot was missing. I still couldn't find the original snapshot of my page either. It figures. A 17-year-old kid's personal design page probably wasn't notable enough for the Wayback Machine to have crawled, or for any of the GeoCities archives to have captured.

I've been using agentic coding tools like Claude and Codex regularly, and I often default to them for brainstorming sessions. Through the process of trying to resurrect the site, I discovered that they are surprisingly capable as partners in digital archival searches through the Wayback Machine. Early explorations helped me understand the Wayback Machine's free [JSON API](https://archive.org/help/wayback_api.php). I could tweak URL parameters and use regex matching to quickly search for assets or even partial URL slugs. Using that, I was able to recover some of the things I was missing.

## The stories GeoCities markup tell

The first thing I noticed when opening the site's index page was actually the name of the file itself: `index.htm`. Opening it in [Zed](https://zed.dev/) threw a UTF-8 error: `stream did not contain valid UTF-8`, which jogged my memory about early web browsers and encodings that may have predated UTF-8. The encoding markup in the HTML showed up as a Latin encoding, which surprised me, but the `meta` tags in the markup told more of the story:

```html
<META HTTP-EQUIV="Content-Type" CONTENT="text/html; charset=iso-8859-1">
<META NAME="GENERATOR" CONTENT="Mozilla/4.04 [en] (Win95; I) [Netscape]">
```

The `GENERATOR` tag shows I was using Netscape Communicator 4.04, which at the time included Netscape Composer, a WYSIWYG HTML editor. `[en]` is for English.

Claude told me that in the late '90s, the Windows 95 English version I was using likely would have used *Windows-1252* (Western European) as its default, and *Netscape Composer* defaulted to *ISO-8859-1* for HTML files when set to the English locale. Interestingly, these two encodings are nearly identical and only differ in a few code points—but I knew none of that back in 1998.

As I explored the markup, I made a happy discovery: I was able to confirm the original GeoCities slug and neighborhood my page was part of, [http://geocities.com/SunsetStrip/Palladium/4011](http://geocities.com/SunsetStrip/Palladium/4011). Alas, I still can't seem to find an original copy in any of the online archives. GeoCities was *huge* though, and it seems like preservation efforts probably started too late for just how big that part of the internet was at the time.

My archive had a mix of 3-character and 4-character filename extensions for the markup itself—`index.htm` and `contactpage.html`. I was wondering why and did some digging. Claude told me this was another artifact of DOS `v8.3` filename conventions, which had clearly influenced early web development. Part of me vaguely recalls Microsoft FrontPage 98 being fond of using 3 character extensions.

Anyway, I updated all the markup files to use a `.html` extension and updated all my internal links accordingly.

## Claude as digital archivist

I ended up leveraging Claude as a kind of digital archivist to help me fix everything that was wrong with the site, but I instructed it to take extra care not to fundamentally change anything. We fixed the broken encoding, standardized filename extensions, dealt with missing images, cleaned up invalid characters that appeared when I converted to `UTF-8`, and added missing closing tags so my liberal use of `<CENTER>`, `<FONT>`, and `<TABLE>` would render properly again.

I had assumed this site predated the W3C validator, but a quick search showed it had just launched in late 1997. It clearly wasn't on my radar at all, as I recall becoming much more concerned with validation only once [XHTML and an official validator](https://en.wikipedia.org/wiki/XHTML) launched a few years later in 2000.

It was a similar story for CSS: the frequent use of stylistic attributes like `border`, `bgcolor`, `height`, and `width` at the time had me wondering if the site predated CSS, but a cursory glance at the W3C spec told me I just didn't know about it yet and leaned heavily on the tools in my toolbox and what all the other codegen tools like GeoCities were doing at the time: inline styles, tables for layout, and gratuitous use of animated `.gif` files!

A whole bunch of JavaScript was still there trying to load and execute, and the popups still fired!

```html
<SCRIPT LANGUAGE="javascript">
var cuid= "10199"; var keywords= "none";
var urlOfNewPop="http://www.geocities.com/ad_container/pop.html?cuid="+cuid+"&keywords="+keywords; oldPop=window.open(urlOfNewPop, '_popIt', 'width=515,height=125');

if (oldPop.location.href != urlOfNewPop) {
  if ((navigator.appName == "Netscape") && (parseInt(navigator.appVersion) == 3)) {
    setTimeout("oldPop.close()", 750);
    setTimeout("window.open(urlOfNewPop, '_popIt', 'width=515,height=125')", 1700);
  } else {
    oldPop.close();
    setTimeout("window.open(urlOfNewPop, '_popIt', 'width=515,height=125')", 1000);
  }
}
</SCRIPT>
```

> The infamous GeoCities popup JavaScript, which still works if you allow popups.

## As was the fashion at the time

Digging into some of the image files was illuminating. I discovered all kinds of format “carbon-dating” clues in the metadata: image dimensions and even which tools were used to create them! This was very helpful, because nearly all of the images in the markup had dimension attributes, and it was useful to correlate which ones matched the files on disk—many of which had different names for some reason. Perhaps an artifact of when I had uploaded them to GeoCities? I have very vague memories of using a web editor for pasting snippets of HTML and uploading images. God, I feel old.

Most of the JPEG files were `.jpg` and contained JFIF headers (JPEG File Interchange Format) at 72 DPI resolution—pretty much a standard for web graphics at the time. GIF files were version `89a`, one of the first versions that supported transparency and animation. The animations were built with [GIF Construction Set](https://www.mindworkshop.com/gifcon.html), and a lot of the artwork was done with Photoshop 4.0.1.

<aside>I was most definitely a "lens flare" and "difference clouds" enjoyer.</aside>

## An exploration partner

This whole exploration was a lot of fun. I don't know about you, but looking back that far into the past definitely brought me right back to where I was as a 17-year-old working on the core pieces of the web and not knowing a damn thing about it.

It was fun to have an LLM partner throughout my explorations too. I think there's a lot of emphasis on using AI for generating new content, but the more I use these tools and default to them, the more I find them to be really powerful partners for exploration and, in this case, digital archaeology. They are able to recall a lot of information about obscure old tech, which isn't surprising—they were trained on a lot of the public internet. The fact that they can quickly reference spec files, jump back in time, look at and understand deprecated APIs and historical file formats, read 25-year-old code, understand the intent with enough context, and help me fix it—that's pretty cool.

This also got me thinking about other ways to use this capability. One of the other things I discovered on my backup disk was a lot of early internet art I had created—3D animations from a pirated copy of 3D Studio Max, an old hand-rotoscoped lightsaber test video, and even an old Half-Life 2 steam skin that crashed my web host in the early 2000's. Those are stories for another time. But one of the things I'm interested in exploring next is maybe building a Claude Skill to time-warp back to the nineties—to impart enough knowledge in the skill definition that Claude could build a new site, but with all the constraints, techniques, and style of the time.

If nothing else, this convinced me that LLMs aren't just for generating new stuff—they're weirdly good at helping us dig up, understand, and preserve the old, broken, wonderful corners of the web too.

For now, I'm pretty happy that I found my backup archive and that I was able to restore my site. Here it is in all its glory: [1998.davemo.com](https://1998.davemo.com)
