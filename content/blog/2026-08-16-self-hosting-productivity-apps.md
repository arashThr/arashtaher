+++
title = "Self-hosting productivity apps"
date = "2026-08-16T18:32:00.000Z"
tags = [ "self-host", "docker", "linux", "productivity" ]
+++

I have started a Joplin instance on my server. With that, now I'm running all these services on a $5 Hetzner server:

- [Pensive](https://getpensive.com/): Bookmarking
- [Hugo flow](https://hugo.arashtaher.com/): Writing blog posts
- [Memos](https://memos.arashtaher.com/): Learning and TIL
- [Joplin](https://joplinapp.org/): Notes

So far I'm pleased with the value I'm getting out of such a cheap server.

Thanks to Docker, there's little to no effort in starting the services.

### Backups and snapshots

Automatic backups are enabled (although 20% of the service price seems a bit high to me).

I also occasionally stop the server to take a snapshot. As long as you have `restart: always` in your Docker Compose files, or stop the Docker service before shutting down the server, nothing manual is needed after starting the server again.

## Plans ahead

More and more I'm considering hosting [Immich](https://immich.app/) and [Jellyfin](https://jellyfin.org/) on that server. I need to move to a bigger server, but I think it is worth it.

Especially I'm excited about Jellyfin. I intend to take a more active role in the music I listen to. There was a time I used to listen to whole albums instead of just a handpicked set of the best of the best. That lets you make a deeper connection with the work.

This would not be the first time I've tried to self-host these apps. Once I attempted hosting them on my laptop at home (using Tailscale). It worked, but there are some issues with consistency and speed. Unless I get a proper mini PC or a server for home, I think pushing that to a VPS is better.