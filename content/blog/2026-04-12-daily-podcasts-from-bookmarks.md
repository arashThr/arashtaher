---
title: "Daily Podcasts From Bookmarks"
date: 2026-04-12T13:10:49+02:00
tags: ["ai", "llm", "pensive", "podcast"]
---

Every morning, right when I'm checking the market to see the sharp decline of my investments, I receive a summary of all the articles I've read the day before in the form of a podcast.

This is the new feature that I added to my bookmarking solution, **[Pensive](https://getpensive.com)**: It will look at all the articles I've read the day before, and create a podcast for me from that. A perfect listen to get me "in the mood for work".

Above all, this project has turned into a field for me to experiment with AI and learn more about it.

Here's what I learned from implementing this feature:
- To keep the costs low, first I tried an open source solution named **["Kokoro"](https://github.com/hexgrad/kokoro)**. I managed to make it work, but my poor $5 per month Hetzner server was overwhelmed by the sheer amount of processing. I have no rush to get my daily podcast, so it can take as much time as it needs, but I want reliability. Something that the solution did not have. So I moved on.
- Then I checked ElevenLabs. It was good... very good. But there's no way I pay that much money for the smooth sexy voice of Alejandro.
- In the end, I landed on Google Vertex AI TTS service. Big lesson here is that Google not only sucks in UI **[(article)](https://danielmiessler.com/blog/google-is-getting-left-behind-due-to-horrible-ui-ux)**, but also in API and services. Go with Googleonly if you want to keep things cheap. Integration with ElevenLabs would be much easier and faster. One tip: You will probably get lost in Google's labyrinth of services, so use their LLM service to navigate around the docs. It was helpful for me.

And here goes another step toward making the bookmarking solution I really deserve, not that I really need.  
Now go and put a star on the project, and I will send you a personal message thanking you for being a great human being.

Do you have any experience working with TTS services? Any recommendations here?

---

Are you interested in open source and want to contribute? Here are some of the future plans I have for Pensive:
- Organizing content in a structured directory-based system. Doing this, we will have the chance to also create a wiki from all your readings - Inspired by **["LLM Knowledge Bases" tweet from Andrej](https://x.com/karpathy/status/2039805659525644595)**
- Capturing content from YouTube and Podcasts.
- Adding a TIL section. Right now I'm using **[Memo](https://github.com/usememos/)** and I want to bring it to Pensive

Not into the code and prefer to touch grass? Then contact me, I can give you a promo code so you can try it and tell me how much my app sucks and why.
