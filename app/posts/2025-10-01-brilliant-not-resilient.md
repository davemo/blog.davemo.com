---
title: "Brilliant, Not Resilient"
date: "2025-10-01"
description: "At Staff+, technical brilliance opens doors, but staying useful when the plan isn't yours is what keeps you in the room."
social_img: "/img/brilliant-not-resilient/social-card.png"
---

<aside class="tldr">
Smarts™ aren't your career bottleneck; staying engaged in hard conversations is, especially when the plan isn't yours.
</aside>

I recently finished reading [The Courage to Be Disliked](https://www.goodreads.com/book/show/43306206-the-courage-to-be-disliked) and thought it would be a good time to reflect on one of the more painful episodes in my career through the lens of resilience, [trust](https://blog.davemo.com/posts/2021-12-21-management-debt-costs-and-trust-capital.html), and the idea of separation of tasks that the book discusses so effectively.

## The Website Redesign That Didn't Ship

One of my last projects at [Pulley](https://pulley.com) was a full [website redesign prototype](https://new.pulley.com). We had been struggling with the previous design and page sprawl for a while, and I was interested in taking a crack at a fresh vision in collaboration with our design team. Within about a week we had shipped a working prototype that included: a cleaner hero section, scroll-to-reveal animated content, an FAQ and comparison table, a clean pricing page, and a few templates and components intended to make shipping pages faster and more reliable.

We were experiencing both design and information architecture drift for a while, and it felt like a lot of that was being caused by our reliance on the CMS we were using at the time, Webflow. I could probably write a whole other post about all of the downstream impacts of choosing a WYSIWYG CMS for your marketing website, but this is not that blog post. Suffice it to say, we were dealing with a lack of cohesion in content building blocks, which resulted in many of the pages that were being created hitting that uncanny-valley effect that no founder wants to see on their web presence: off-by-one pixel counts on border radii, slightly varied colors that deviated from the design palette, or the dreaded font styling someone added to place emphasis at just the right place for their one-off marketing page.

It was a fun project—until it wasn't. The closer we got to _make it real_, the fuzzier the ownership became. It was especially fun to work with my preferred publishing stack—Markdown and [Astro](https://astro.build)—but a challenge emerged in my efforts to move the ball forward from prototype to production: it wasn't clear who would decide or own the outcome.

## The Dreaded DRI

A week after shipping the prototype we had a company offsite, during which there was a renewed charter and some tweaks to our company values. One of my favorite things about the culture at Pulley was the company values around "default public", "ship it and iterate", and "disagree and commit". At the offsite, a new value landed for us: "stick your neck out." Have a good idea? Move it forward. We needed people who would make bold bets and take risks with conviction. Heck yes, that was exactly what I needed to hear and I leaned into it pretty hard, hoping to be able to drive the website project forward.

I ended up making a pitch to leadership to be the DRI (directly responsible individual), and had received a yes, if somewhat reluctantly. This should have been my first clue that alignment on "stick your neck out" hadn't translated into alignment on _who_ owned the outcome.

Undeterred (or perhaps more accurately, painfully unaware) I kept moving things forward as best I could, looping in folks from the marketing department as well as our COO at the time to make my strongest pitch for moving off Webflow and into a Markdown-based publishing pipeline. This appeared to be well received, and it felt like I was being appropriately rewarded for having stuck my neck out.

## My Misdiagnosis

A few weeks later, a contractor joined the project; someone our COO had worked with before, and was positioned as someone who would help me get the project over the finish line. At first I was glad to have the help, someone else to brainstorm with, and someone who was in favour of the approach I had selected, with a slight twist; they suggested we use a headless CMS. It started out fine, we collaborated to migrate my prototype over to use the headless CMS and Astro, and then meetings started to have more people involved. The COO began coordinating things and driving, deferring many of the decisions to the contractor. None of this happened with clear communication, no one said who was driving, and ownership started blurring right at the moment when I felt like we had forward momentum.

This was confusing to me, and I started to ask questions about things in our public channels, hoping to gain clarity about who owned the effort, leaning into our _mostly_ healthy operating mode of "default public" for comms.

I ended up in a 1:1 with both the CEO and COO (or is that a 2:1?) where some honest feedback came for the first time: "Dave, you're brilliant, but you're not resilient, and what we really need are people who are resilient". I tried to dig into that feedback to better understand it, but I was also struggling with having felt somewhat blindsided by the rapid shift in gears in a process and initiative I was helping drive forward to something being delegated to a contractor.

I ended up shutting down hard after that—pretty much fulfilling the prophecy from the 1:1 feedback. A month later, I ended up leaving the company.

In retrospect, the feedback wasn't really the problem; it was that I couldn't tell if we were in *Disagree & Commit* (a plan exists, follow it) or *Ship & Iterate* (we don't have a plan, keep narrowing and we'll decide later), and I didn't actually ask—I just shut down. Leadership had quietly shifted us into *Disagree & Commit* on a contractor-led plan, and I was still operating as if we were in *Ship & Iterate*.

## Not My Plan, Still My Job

One of the most useful lessons from Courage to Be Disliked is that of the separation of tasks. If you haven't read it, the book is structured as a dialogue between a youth and a philosopher over five nights, exploring many of the themes in [Adlerian Psychology](https://en.wikipedia.org/wiki/Individual_psychology)—an excerpt on the topic of separating tasks from page 122:

> **PHILOSOPHER**: One does not intrude on other people's tasks.

The conversation in the chapter continues with much more specific examples, but this snippet is enough to illustrate what I think I was missing: a concrete understanding of what my task was in the website redesign project, and perhaps what it began as and how it changed as the situation evolved.

This has led me to a much more useful habit during introspection or when I sense myself getting frustrated: clearly separating my task from not-my-task. Reflecting on the website project:

- *My task*: propose, prototype, learn, align, and be useful _within whatever route is chosen_.
- *Not my task*: control final adoption; dictate the plan if a new DRI has been designated; personally resolve every stakeholder tension.

Had I been able to make that separation explicit, I think I would have done two things differently: (1) _commit_ to the contractor-led plan and contribute high-leverage work inside of it, or (2) _request_ a return to iteration mode with a timeboxed v2.0 and explicit decision checkpoints. Instead, I kind of just stayed stuck between modes and felt trapped by constraints.

## Trust & Operating Modes

"Disagree & Commit" works when the goal is shared but the route is contested. It requires and rests on trust: I trust the decider's taste and judgment enough to set aside my preferred route and still give my best efforts. "Ship & Iterate" is different: it assumes we're still shaping the route, so the job is to _show work_, gather feedback, and narrow quickly.

In my case, I had trust in the _person_: I trusted my CEO's judgment and sense of what good looked like. But I didn't have trust in the _system_: the unclear DRI, the surprising plan change, and the hazy timebox made it challenging to know how to be useful.

This distinction matters. You can be resilient when the plan is clear but hard—when you know what operating mode you're in and what's expected. Unclear expectations make staying resilient far harder. Without clarity on operating mode and ownership, even well-intentioned people spin their wheels or shut down.

These are solvable alignment problems—_if_ you name what mode you are operating in and ask for clarity:

> Before we continue, can we confirm our operating mode? Are we in *Commit to  Contractor's Plan* or *Iterate Toward a Decision*? If it's the former, I'd like to propose 2-3 contributions inside that plan by Friday. If it's the latter, I'll work on a few more iterations focusing on hero/information-architecture/templates—also by Friday.

What I like about this is it demonstrates curiosity, seeking to understand, and shows alignment and a bias for action regardless of what operating mode we're in. Had I done this, I feel like I would have kept myself in the arena a lot longer and been much more resilient to changing dynamics; resisting the temptation to become frustrated over things that simply weren't my task.

Maybe you find yourself in a similar position; your organization might be adopting another plan than the one you had in mind. If that's true, then you have a choice to make about how you show up and engage, and if you want to be seen as someone who is resilient, then you need to have the right mindset going into that potential minefield of career-limiting moves.

Resilience doesn't mean silence or shutting down; it means finding how to be *useful within constraints* and driving towards clarity when expectations aren't clear.

## My Resilience Playbook

In the time between the website project and now I've worked with six other clients and made a return to working at [Test Double](https://testdouble.com/team-directory/dave-mosher) as a full time consultant, and I've picked up a few tricks along the way that have helped me reframe my typical defensiveness when receiving feedback like I got from my CEO into a positive set of steps that help to keep me in the arena:

1. **Pause** Feeling defensive? Name it, out loud or in your head, or to the other person if trust is high. Give it 30 minutes or so.
2. **Separate Tasks**. What is mine to own _right now_? What is not?
3. **Identify the Operating Mode**. Are we in "Disagree & Commit" or "Ship & Iterate", or maybe even "Stick Your Neck Out"? Ask explicitly.
4. **Contribute, don't Control**. "What is the most useful thing I can contribute within these constraints?"
5. **Close the Loop**. Propose a timeboxed next step; confirm the owner and timeline.

If it helps, here's a phrase you might use in such a scenario:

> I'm hearing X and Y aren't landing. I'll regroup and come back with options by Friday EOD. Can you confirm whether we're committing to Plan A or still in iterate-toward-spec mode? That changes how I'll structure my next pass.

## Staying in the Room

Reflecting on this honestly has helped me realize that the feedback that led to me quitting has been a pretty effective catalyst for growth; it has helped me distinguish _trust in the plan_ from _iteration stamina_, separate my tasks from others', and trade defensiveness for a contribution-within-constraints mindset when I'm not the decision maker.

As I've been considering what is necessary to move further into senior levels of leadership in my career, it seems to me that being the smartest person in the room is much less important than simply just being in the room, especially when the plan isn't yours.

At Staff+, brilliance _might_ open doors, but it's resilience—staying useful and engaged even when the plan isn't yours—that keeps you in the room and leads to more opportunities to learn and grow. The next time ownership blurs or plans shift, my hope is that you (and I) will know what to ask and how to show up.
