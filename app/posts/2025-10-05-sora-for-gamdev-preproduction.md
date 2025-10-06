---
title: "Sora 2 for Lookdev"
date: "2025-10-05"
description: "How I used Sora 2, GPT-5, and Codex to generate consistent character lookdev assets, A-pose references, and 3D meshes for indie game pre-production in a few hours."
social_img: "/img/sora-for-gamedev/social-card.png"
---

<aside class="tldr">
Sora is a surprisingly capable idea generator for gamedev pre-production.
</aside>

I spent a few hours yesterday experimenting with Sora 2, trying to figure out if it could help with asset pre-production for a game idea I've been noodling on for about a year. Turns out, it's a pretty capable partner—with caveats. You can get solid consistency in *format* (camera angles, poses, framing) by being specific in your prompts, but aesthetic consistency—the actual look and feel across generations—is still a crapshoot.

The levers for locking down visual style just aren't there yet, or at least not exposed. Still, for pre-production exploration and prototyping? It's pretty damn useful if you set the right expectations.

## My GameDev Origins

Before I became a full-time programmer, I was into 3D graphics and graphic design. We got our first family computer in 1996—an Acer Aspire with a knockoff Cyrix 6x86-P133 chip. I cut my teeth on pirated copies of Photoshop, Illustrator, and 3D Studio Max—downloaded over dialup—diving deep into the world of 3D modeling, texturing, and animation. I never quite mastered rigging (inverse kinematics confused the hell out of me), but I was obsessed.

[Blender](https://www.blender.org/) first got on my radar around this time, back when it was freeware, pre-OSS release (I think I started around version `1.6`). I loved working in Blender because it was small, capable, and I didn't have to sail the high seas. 🏴‍☠️

As I got deeper into 3D work, I naturally gravitated toward level design—first with [Ken Silverman's Build Engine](https://en.wikipedia.org/wiki/Build_(game_engine) (Duke Nukem 3D), then later with Valve's [Worldcraft](https://en.wikipedia.org/wiki/GoldSrc#:~:text=Worldcraft) (Half-Life). There was something satisfying about building playable spaces, not just rendering static scenes. That's what eventually pulled me into the world of game modding.

Fast forward to 2003: [S2 Games](https://en.wikipedia.org/wiki/S2_Games) had just released [Savage: The Battle for Newerth](https://en.wikipedia.org/wiki/Savage:_The_Battle_for_Newerth). I met a team of devs on Freenode who were building a mod on top of the Silverback engine, and I dipped my toes into the gamedev industry properly for the first time.

The mod didn't really go anywhere—I can't even remember the name of it—but I found myself far more interested in the web dev side and poured my energy into building our little modding team's web presence and styling the [phpBB](https://www.phpbb.com) installation we had going to manage development. Still, that experience gave me a taste of the gamedev pipeline: concepting, pre-production, asset production, prototyping, playtests. Some 25 years later, that foundational knowledge is proving useful as I re-engage with gamedev.

## The Game Idea

The concept is simple: a dwarven-themed take on the excellent [Moonlighter](https://moonlighterthegame.com), with a twist. Instead of being a shopkeeper, you're an innkeeper. You run an inn during the day—making food, breaking up bar fights between dwarven patrons, earning coin to invest in better furnishings. Instead of "moonlighting" in dungeons after hours, you go hunting, gathering, fishing, and foraging for higher-quality ingredients to feed your ever-hungry customers. Part sim, part survival-lite.

I have some lofty goals for multiple gameplay loops, but I've set those aside to just start prototyping and producing assets. That's where Sora 2 comes in.

## Lookdev and AI

Today, we have these incredibly powerful idea engines that let us produce assets in minutes—assets that would've taken days for a single artist just a few years ago. Sure, they're low quality and better suited for prototyping right now, but the speed is transformative.

I started with a basic question: **What type of prompt would I need to get Sora to produce lookdev assets for a dwarven innkeeper in a neutral pose?**

## Early Experiments: Finding the Aesthetic

My early prompts explored stylistic elements—texture, theme, stylized vs. photorealistic. I ping-ponged between Sora and GPT-5, using the latter to educate me on formal terminology I'd forgotten or never learned.

Here are some early attempts:

> 2.35:1 cinematic, 24fps. Opening wide shot (24mm) eye-level, slow push-in through bustling dwarven taproom with flagstones, oak beams, rune-carved pillars. Warm 3000K firelight + practical candles, soft rim lighting; gentle haze for light rays. Cut to medium (50mm) tracking left as innkeeper (braided beard, leather apron) slides tankard; shallow DOF. High-detail props: copper taps, carved mugs, stew steam. Final close-up (85mm) with rack focus at 8s from stew to ledger UI: minimalist diegetic overlay (gold coins + rep meter). Teal-orange grade, subtle 35mm film grain, Deakins-style naturalism. Natural motion blur, clean cut transitions.
<figure class="featurette">
  <video controls autoplay loop muted playsinline>
    <source src="/img/sora-for-gamedev/lookdev_style_exploration_1.webm" type="video/webm">
    Your browser does not support the <code>video</code> tag.
  </video>
</figure>

> One unbroken 10s take, 60fps, real-time gameplay capture. Low-poly dwarven tavern with toon outline shader and flat color ramps. Third-person shoulder cam follows the innkeeper from keg to bar; smooth, game-like acceleration/deceleration. Patrons in looping emotes (cheer, sit, wave). Lighting: high-key warm directional + baked bounce; crisp shadows. Foam as simple particle sprites; stew steam as billboard particles. HUD: thin outlined panels with bold pictograms; +10 coins tick at top-left, Order Served toast top-right. No cuts, no photo montage, no still frames. Loop seamlessly.
<figure class="featurette">
  <video controls autoplay loop muted playsinline>
    <source src="/img/sora-for-gamedev/lookdev_style_exploration_2.webm" type="video/webm">
    Your browser does not support the <code>video</code> tag.
  </video>
</figure>

> Real-time gameplay capture, continuous 10s, 60fps, no cuts. Third-person follow cam tracking a dwarven innkeeper jogging through misty conifer forest at blue hour; hand-painted terrain, stylized-PBR foliage; volumetric fog and light shafts. Subtle head-bob, camera eases around trees; IK foot planting. The character harvests glowing chanterelles (bioluminescent), +1 ingredient appears as tiny rune HUD near the mushrooms, then fades. Audio: soft wind, branch creaks, cloth rustle. Cool teal environment vs warm fungus glow; mild DOF; foamless motion blur. Seamless loop.
<figure class="featurette">
  <video controls autoplay loop muted playsinline>
    <source src="/img/sora-for-gamedev/lookdev_style_exploration_3.webm" type="video/webm">
    Your browser does not support the <code>video</code> tag.
  </video>
</figure>

These experiments were fun, but not exactly what I was looking for. They helped me identify what I liked aesthetically and gave me a sense of Sora's capabilities. As I refined my prompts, I realized there was likely a more structured approach that would help with look tests of characters, props, and animations.

## The "What Ifs"

Like any good coding rabbit hole, my journey had me wondering:

- What if I could get consistent character outputs from Sora?
- What if I could use those to generate A-pose and other lookdev assets that a traditional 3D artist might use?
- What if I could take that asset and auto-generate a rough pre-production mesh?
- What if there existed a tool that could auto-edit and auto-rig the model so I could drop it into a test level?

I didn't get to that last one (yet!), but I did accomplish the first three. And honestly? It's really damn cool. We're living in the most amazing version of "draw the rest of the owl" I ever imagined possible, and if you have any creativity whatsoever and a vision for what good looks like, it's such an energizing time to be a builder of things.

## Constraining Sora to Give Consistent LookDev Outputs

Once I realized you could constrain Sora with detailed prompts—including key lighting, temperature, intensity, materials, specific geometry, animation loops—I started experimenting more deliberately.

The thing is, I'd been away from game production for about twenty-five years, and the industry has evolved *massively* in that time. Back when I was doing this stuff, I was entirely self-taught, scraping together knowledge from forums and tutorials. There's a whole professional vocabulary and standardized pipeline terminology now that didn't really exist—or at least wasn't codified—when I was working in 3D Studio Max and early Blender. I just didn't know what I didn't know.

So I leaned on GPT-5 as an educator. I found that shifting my role to that of a learner, and being specific about my background, was surprisingly effective context engineering. I told GPT-5 about my gamedev history, and it would respond with, "Ah yes, these are the pieces of the pipeline you're describing, and here's the modern terminology and keywords—here's how to put it together in a prompt for Sora."

The challenge was getting stylistic consistency. I went through many iterations, some decent but not quite the aesthetic I wanted. When I found something I liked, I doubled down on it, tweaking prompts to try and maintain a common theme.

The key insight here: *specificity breeds consistency*. The more detailed your prompt about lighting, materials, pose, and camera behavior, the more control you have over the output. When you don't know what you don't know, you can ask GPT-5 or another LLM to help bridge that gap, translating your intent into the precise terminology that makes prompts more effective.

## Example Prompts That Worked

> Real-time character lookdev test, one continuous take, 10 seconds, 60fps, no cuts, no still frames, no timelapse. Locked front orthographic camera, waist-up to full-body framing, centered. Painted-toon hybrid: low/medium-poly forms, hand-painted albedo with visible brush strokes, stylized-PBR lighting, thin 1–2px toon outlines, two-step shadow ramps (teal shadows, warm highlights). Dwarven innkeeper: braided beard, leather apron, oak-tone bracers, stout silhouette. Idle animation: slow breathing, slight weight shift, tiny head turn, natural blinks; beard/cloth secondary motion; subtle finger fidgets. Lighting: soft key 3000–3500K from screen-left, rim from screen-right 5000K, gentle bounce; neutral backdrop (oak-grain or mid-gray). No camera move, no DOF, natural motion blur minimal. Turn on shader cues: specular on brass buckles, matte leather roughness, painted wood grain. Loop seamlessly end-to-start.

<figure class="featurette">
  <video controls autoplay loop muted playsinline>
    <source src="/img/sora-for-gamedev/lookdev_consistency_exploration_1.webm" type="video/webm">
    Your browser does not support the <code>video</code> tag.
  </video>
</figure>

> Real-time character turnaround test, continuous single take, 10s, 60fps. Locked camera, character rotates 360° clockwise at constant speed on a turntable; no cuts. Painted-toon hybrid look: hand-painted textures, thin toon outlines, two-step shadow ramps, stylized-PBR highlights on brass fittings. Lighting: three-point—key 3200K, fill −1.5 EV, cool rim 5500K; floor card for bounce. Animation: subtle idle breathing while rotating; beard/cloth secondary motion; no exaggerated sway. Backdrop: neutral studio sweep; no DOF. Material callouts visible: leather roughness, wood grain on tankard at belt, brushed metal on belt hooks. Seamless loop end-to-start (rotation lands on front exactly at 10s).

<figure class="featurette">
  <video controls autoplay loop muted playsinline>
    <source src="/img/sora-for-gamedev/lookdev_consistency_exploration_2.webm" type="video/webm">
    Your browser does not support the <code>video</code> tag.
  </video>
</figure>

> Real-time lookdev test, one continuous take, 10 seconds, 60fps, no cuts, no still frames, no timelapse, seamless loop end-to-start. Painted-toon hybrid: low/medium-poly forms, hand-painted albedo with visible brush strokes, stylized-PBR lighting, thin 1–2px toon outlines, two-step shadow ramps (teal shadows, warm highlights). Locked front orthographic camera, full-body, centered trio. Neutral mid-gray studio backdrop, no DOF, natural motion blur minimal. Three dwarven innkeeper variants stand side-by-side at equal scale: Tankard-Bearer (broad shoulders), Smith-Chef (apron + skillet on belt), Scout (lighter kit). All perform subtle idle: slow breathing, slight weight shift, natural blinks; beards/cloth secondary motion. High-contrast rim so silhouettes read clearly; lighting constant; no camera move.

<figure class="featurette">
  <video controls autoplay loop muted playsinline>
    <source src="/img/sora-for-gamedev/lookdev_consistency_exploration_3.webm" type="video/webm">
    Your browser does not support the <code>video</code> tag.
  </video>
</figure>

## Getting Sora to Build Useful A-Pose Assets

Early on, I had pulled some Sora outputs into a demo version of Stable Fast 3D, then into Blender, but I ran into a few quality problems with the models. GPT-5 suggested a pre-production cleanup process I could do manually, but it felt tedious and I was really trying to optimize for speed over quality at this stage anyway.

I hadn't considered this ahead of time, and my early assets didn't have enough space between the arms, causing overlapping geometry that would make rigging difficult. So I went back to GPT-5 and learned about [A-poses](https://blender.stackexchange.com/questions/242252/a-pose-or-t-pose)—neutral poses with arms at about 30-45 degrees from the body, rather than straight out (T-pose). This makes it easier for auto-rigging tools to identify limbs.

The frustrating part: as I refined the prompts for better poses, the aesthetic would sometimes shift. And despite my best attempts, Sora often wouldn't complete a full 360° rotation within its 10-second limit.

## A Happy Accident : Character Sheet Plates

I was trying to get a character turnaround and accidentally left in all of the parameters from a prompt that GPT had told me to use one at a time for separate Sora iterations; this ended up causing  Sora to create a character sheet with multiple views. Instead of animating it, Sora generated a static image with front, right-profile, and back views—all on one plate. This turned out to be incredibly useful as a reference to snap screenshots from to use further on down the line for mesh generation.

> Character sheet plate, single still. Dwarven innkeeper, painted-toon hybrid (hand-painted albedo, thin 1–2px outlines, two-step ramps, stylized-PBR highlights kept subtle). Stocky heroic proportions (broad shoulders, short legs), braided beard with clear air-gap from chest, bald crown with close-cropped sides, simple tunic, belt, pants, boots; no props/cape/apron/toolkit. A-pose: arms ~30° down from horizontal, hands open, fingers separated; legs shoulder-width, feet flat on ground plane, head level, neutral face. Camera: orthographic, full-body, perfectly [FRONT / RIGHT-PROFILE / BACK] facing, centered; framing consistent. Background: neutral mid-gray seamless; no DOF, no motion blur. Lighting: even studio three-point (key 5000K softbox, fill −1 EV, soft rim); shadows soft and minimal; materials unchanged. Exposure even, no vignetting, no color cast. Style anchors: warm, hand-painted base colors (muted earth palette: umber leather, slate cloth, iron accents), clean silhouettes, no grunge overlays, readable edge accents on folds and seams. Negative: no pose changes, no stepping, no crossed limbs, no props, no background objects, no text, no logos.

<figure class="featurette">
  <video controls autoplay loop muted playsinline>
    <source src="/img/sora-for-gamedev/lookdev_character_sheet_1.webm" type="video/webm">
    Your browser does not support the <code>video</code> tag.
  </video>
</figure>

## Other A-Pose Prompts That Worked

> Character turnaround, 10s, 60fps, single continuous take, loopable. Painted-toon hybrid (hand-painted albedo, thin 1–2px outlines, two-step ramps, stylized-PBR). Locked orthographic camera, full-body, centered; neutral mid-gray cyc; no DOF, no motion blur. Dwarven innkeeper in A-pose (arms ~30° down from horizontal), legs shoulder-width, feet flat, hands open with fingers separated; head level; neutral face. No props, no cape, no apron, no toolkit. Beard volume clearly separated from chest. Elbows and hands fully visible (no self-occlusion). Character rotates 360° clockwise at constant speed on a turntable; framing constant. Lighting: neutral studio 3-point (key 5000K softbox, fill −1 EV, subtle rim), soft shadows; materials unchanged throughout.

<figure class="featurette">
  <video controls autoplay loop muted playsinline>
    <source src="/img/sora-for-gamedev/lookdev_clean_a_pose_turnaround.webm" type="video/webm">
    Your browser does not support the <code>video</code> tag.
  </video>
</figure>

I've since learned that the best angle for these lookdev assets is a 3/4 view—slightly offset (about 30 degrees) from the front—so you can see depth in the character model.

## Generating Pre-Production Meshes with Stable Fast 3D

Once Sora was producing reasonably consistent assets, I wanted to convert them into 3D meshes I could use in Blender.

Enter [Stable Fast 3D](https://stable-fast-3d.github.io) from Stability AI. You can use their [demo app on Hugging Face](https://huggingface.co/spaces/stabilityai/stable-fast-3d) if you don't want to run anything locally, which is a pretty reasonable way to get pre-production meshes into your pipeline. But it runs pretty quick if you take the time to set it up—even on a Mac. I have an M3 Max with 36GB of RAM, and generating a mesh with 8,000–12,000 polys takes about 20 to 30 seconds.

```shell
~/code/innkeeper/stable-fast-3d git:(main)

PYTORCH_ENABLE_MPS_FALLBACK=1 uv run python run.py ./innkeeper_three_quarter.png --output-dir output/tris --remesh_option triangle --texture-resolution 2048
Device used:  mps
After Remesh 7309 14614
Peak Memory: 11525.65625 MB
100%|█████████████████████████████████████| 1/1 [00:29<00:00, 29.03s/it]
```

> I followed the instructions on the [Stable Fast 3D Repo](https://stable-fast-3d.github.io) to enable [MPS support](https://github.com/Stability-AI/stable-fast-3d?tab=readme-ov-file#support-for-mps-for-mac-silicon-experimental) on my Macbook, and installed pre-requisites using [uv](https://docs.astral.sh/uv/). (You may need to install torch like this: `uv pip install torch --no-build-isolation`).

## The Final Context

After many iterations, I had evolved my prompt to produce an asset with:

- Consistent character dimensions
- A proper A-pose
- Sequential camera cuts showing front, right-profile, back, and 3/4 views
- Proper framing (no clipping of hands, feet, or elbows)

> Character sheet, 10s, 60fps, single take, sequential camera cuts; no motion blur, no DOF. Dwarven innkeeper, painted-toon hybrid (hand-painted albedo, thin 1–2px outlines, two-step ramps, subtle stylized-PBR). A-pose: arms ~30° from horizontal, hands open, fingers separated; legs shoulder-width, feet flat; head level, neutral face; beard with visible air-gap from chest. Camera & framing: orthographic, full-body, subject centered; lock zoom/orthographic size; character occupies ~70–80% of frame height; minimum 10% margin to all edges; no cropping of hands, feet, or elbows at any time; ground plane visible. Aspect 16:9. Background: neutral mid-gray seamless. Lighting constant (even studio three-point: key 5000K, fill −1 EV, soft rim). Timing: 0.0–2.5s = FRONT; 2.5–5.0s = RIGHT-PROFILE (90°); 5.0–7.5s = BACK (180°); 7.5–10.0s = 3⁄4 front-right (≈45°); loop resets to FRONT at 10s. Negative: no props/cape/apron/toolkit; no idle sway; no background objects; no text/watermarks;

<figure class="featurette">
  <video controls autoplay loop muted playsinline>
    <source src="/img/sora-for-gamedev/lookdev_character_sheet_sequential.webm" type="video/webm">
    Your browser does not support the <code>video</code> tag.
  </video>
</figure>

The output *format* has been remarkably consistent, even if the *aesthetics* tend to drift between generations. For prototyping, that's actually fine—I care more about format consistency than aesthetic consistency at this stage. What matters is being able to reliably screenshot these outputs, feed them into Stable Fast 3D, and get usable `.glb` meshes for rapid prototyping. The art style exploration is part of the process; having predictable poses and framing is what makes the workflow viable.

## Automating the pipeline

I've always gravitated toward building internal tools in my software development career—there's something deeply satisfying about being a toolmaker. So I asked myself: could I build a small web app that would:

1. Take an image via command line
2. Automatically generate a mesh
3. Preview multiple quality variants in a web browser

Turns out, you can. I mean, _of course_ you can; we're living in a world where tools you can imagine being useful are just a prompt away from existing, if you're a sufficiently skilled context-smith.

I had GPT-5 and Codex whip up a python script that generates a webpage using [Google Model Viewer](https://modelviewer.dev) to preview the `.glb` meshes that Stable Fast 3D generates (along with basic texture and lighting info). This script lets me batch-create models at varying quality levels and compare them instantly in a browser.

<img src="/img/sora-for-gamedev/image_viewer_optimized.png" />
<img src="/img/sora-for-gamedev/blender_meshes_optimized.png" />

## What I've learned

Here are some key takeaways from this experiment I wanted to leave you with:

1. **Specificity is everything**. The more detailed your prompt—lighting temperature, material roughness, camera behavior, pose angles—the more consistent your outputs.

2. **Embrace happy accidents**. The character sheet plate was a mistake, but it became one of the most useful outputs and guided me further down the rabbit hole.

3. **Use AI as an educator**. Shifting to a "learner" role with GPT-5 and providing context about my background made the guidance far more relevant and actionable.

4. **Prototype fast, iterate faster**. Even with limitations (10-second clips, inconsistent rotations), you can generate enough useful assets in a few hours to kickstart pre-production.

5. **Build tools to reduce friction**. Automating the image-to-mesh-to-preview pipeline makes experimentation far more enjoyable, and it took like 15 minutes of back and forth with GPT-5.

The barrier to entry keeps dropping, and I'm curious how far this type of workflow can scale.

## What's Next?

I still want to explore:

- Auto-rigging pipelines or Blender add-ons
- Using these meshes in [Godot](https://godotengine.org) or [Babylon.js](https://www.babylonjs.com) for actual gameplay prototyping
- Experimenting with environment and prop generation

If you're interested in trying this workflow yourself, everything lives in [davemo/gamedev-preproduction-pipeline](https://github.com/davemo/gamedev-preproduction-pipeline). Feel free to [reach out](https://twitter.com/dmosher) if you want to chat about gamedev pipelines—I'm always happy to trade notes.
